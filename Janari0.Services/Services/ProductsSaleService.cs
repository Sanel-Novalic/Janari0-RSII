using AutoMapper;
using Janari0.Model.SearchObjects;
using Janari0.Services.Context;
using Janari0.Services.IServices;
using Janari0.Services.Requests;

namespace Janari0.Services.Services
{
    public class ProductsSaleService : BaseCRUDService<Model.ProductsSale, Database.ProductsSale, ProductsSaleSearchObject, ProductsSaleInsertRequest, ProductsSaleInsertRequest>, IProductsSaleService
    {
        public ProductsSaleService(Janari0Context context, IMapper mapper) : base(context, mapper) {}
       
        public override IEnumerable<Model.ProductsSale> Get(ProductsSaleSearchObject? search = null)     
        {
            ProductsService productsService = new ProductsService(Context,Mapper);
            var list = base.Get(search);     
            foreach (var productSale in list)      
            {
                var product = productsService.GetById(productSale.ProductId);    
                productSale.Product = product;

            }
            return Mapper.Map<IList<Model.ProductsSale>>(list);
        }       
    } 
}
