﻿using AutoMapper;
using Janari0.Model.Requests;
using Janari0.Model.SearchObjects;
using Janari0.Services.Context;
using Janari0.Services.Database;
using Janari0.Services.IServices;
using Microsoft.ML;
using Microsoft.ML.Data;
using Microsoft.ML.Trainers;

namespace Janari0.Services.Services
{
    public class ProductsSaleService
        : BaseCRUDService<Model.ProductsSale, Database.ProductsSale, ProductsSaleSearchObject, ProductsSaleInsertRequest, ProductsSaleUpdateRequest>,
            IProductsSaleService
    {
        public ProductsSaleService(Janari0Context context, IMapper mapper)
            : base(context, mapper) { }

        public async Task<IEnumerable<Model.ProductsSale>> GetCarouselData(ProductsSaleSearchObject? search = null)
        {
            ProductsService productsService = new(Context, Mapper);
            var list = await base.Get(search);
            List<Model.ProductsSale> productsSale = new();
            if (search?.Carousel == "Nearby")
            {
                foreach (var productSale in list)
                {
                    LocationService locationService = new(Context, Mapper);
                    var location = await locationService.GetById(productSale.LocationId);
                    productSale.Location = location;
                    var distance = getDistance(search.Latitude, search.Longitude, productSale.Location.Latitude, productSale.Location.Longitude);
                    if (distance < 5000)
                    {
                        var product = await productsService.GetById(productSale.ProductId);
                        productSale.Product = product;
                        productsSale.Add(productSale);
                    }
                }
            }
            else
            {
                foreach (var productSale in list)
                {
                    if (productSale.Price == "Free")
                    {
                        var product = await productsService.GetById(productSale.ProductId);
                        productSale.Product = product;
                        productsSale.Add(productSale);
                    }
                }
            }
            return productsSale;
        }

        public double getDistance(double longitude, double latitude, double otherLongitude, double otherLatitude)
        {
            var d1 = latitude * (Math.PI / 180.0);
            var num1 = longitude * (Math.PI / 180.0);
            var d2 = otherLatitude * (Math.PI / 180.0);
            var num2 = otherLongitude * (Math.PI / 180.0) - num1;
            var d3 = Math.Pow(Math.Sin((d2 - d1) / 2.0), 2.0) + Math.Cos(d1) * Math.Cos(d2) * Math.Pow(Math.Sin(num2 / 2.0), 2.0);

            return 6376500.0 * (2.0 * Math.Atan2(Math.Sqrt(d3), Math.Sqrt(1.0 - d3)));
        }

        public override async Task<Model.ProductsSale?> GetById(int id)
        {
            var set = Context.Set<ProductsSale>();

            var entity = await set.FindAsync(id);

            if (entity == null)
            {
                return null;
            }

            var productsService = new ProductsService(Context, Mapper);

            var product = await productsService.GetById(entity.ProductId);

            entity.Product = Mapper.Map<Product>(product);

            return Mapper.Map<Model.ProductsSale>(entity);
        }

        public override async Task<IEnumerable<Model.ProductsSale>> Get(ProductsSaleSearchObject? search = null)
        {
            var list = await base.Get(search);

            ProductsService productService = new(Context, Mapper);
            foreach (var item in list)
            {
                var product = await productService.GetById(item.ProductId);
                item.Product = product;
            }
            return list;
        }

        public override async Task BeforeDelete(Database.ProductsSale dbentity)
        {
            BuyersService buyersService = new(Context, Mapper);

            foreach (var item in dbentity.Buyers)
            {
                await buyersService.Delete(item.BuyerId);
            }
        }

        static MLContext? mlContext = null;
        static ITransformer? model = null;

        public async Task<List<Model.ProductsSale>> Recommend(int id)
        {
            var allItems = Context.ProductsSales.AsQueryable();

            ITransformer trainedModel;
            try
            {
                trainedModel = await ModelTrainer(id);
            }
            catch (Exception e)
            {
                var get = await Get();
                return get.ToList();
            }

            var predictionResult = new List<Tuple<Database.ProductsSale, float>>();
            foreach (var item in allItems)
            {
                var predictionEngine = mlContext.Model.CreatePredictionEngine<ProductEntry, Copurchase_prediction>(trainedModel);

                var prediction = predictionEngine.Predict(new ProductEntry() { ProductSaleID = (uint)id, CoPurchaseProductSaleID = (uint)item.ProductId });

                predictionResult.Add(new Tuple<Database.ProductsSale, float>(item, prediction.Score));
            }

            var finalResult = predictionResult.OrderByDescending(o => o.Item2).Select(s => s.Item1).Take(3).ToList();

            ProductsService productService = new(Context, Mapper);
            if (finalResult != null)
            {
                foreach (var item in finalResult)
                {
                    var product = await productService.GetById(item.ProductId);
                    item.Product = Mapper.Map<Product>(product);
                }
            }
            return Mapper.Map<List<Model.ProductsSale>>(finalResult);
        }

        public async Task<ITransformer> ModelTrainer(int id)
        {
            if (mlContext == null)
            {
                mlContext = new MLContext();

                OrdersService ordersService = new(Context, Mapper);
                OrderSearchObject orderSearchObject = new() { UserId = id };

                var tmpTask = await ordersService.Get(orderSearchObject);
                var tmp = tmpTask.ToList();

                var data = new List<ProductEntry>();

                foreach (var item in tmp)
                {
                    if (item.OrderItems.Count > 1)
                    {
                        var distinctItemId = item.OrderItems.Select(s => s.ProductSaleId).ToList();

                        distinctItemId.ForEach(x =>
                        {
                            var relatedItems = item.OrderItems.Where(w => w.ProductSaleId != x);

                            foreach (var y in relatedItems)
                            {
                                data.Add(new ProductEntry() { ProductSaleID = (uint)x, CoPurchaseProductSaleID = (uint)y.ProductSaleId, });
                            }
                        });
                    }
                }

                var trainData = mlContext.Data.LoadFromEnumerable(data);

                MatrixFactorizationTrainer.Options options = new MatrixFactorizationTrainer.Options();
                options.MatrixColumnIndexColumnName = nameof(ProductEntry.ProductSaleID);
                options.MatrixRowIndexColumnName = nameof(ProductEntry.CoPurchaseProductSaleID);
                options.LabelColumnName = "Label";
                options.LossFunction = MatrixFactorizationTrainer.LossFunctionType.SquareLossOneClass;
                options.Alpha = 0.01;
                options.Lambda = 0.025;
                options.NumberOfIterations = 100;
                options.C = 0.00001;

                var est = mlContext.Recommendation().Trainers.MatrixFactorization(options);

                model = est.Fit(trainData);
            }

            return model;
        }
    }

    public class Copurchase_prediction
    {
        public float Score { get; set; }
    }

    public class ProductEntry
    {
        [KeyType(count: 2000)]
        public uint ProductSaleID { get; set; }

        [KeyType(count: 2000)]
        public uint CoPurchaseProductSaleID { get; set; }
        public float Label { get; set; }
    }
}
