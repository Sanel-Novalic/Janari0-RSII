using AutoMapper;
using Janari0.Model;
using Janari0.Model.Requests;
using Janari0.Model.SearchObjects;
using Janari0.Services.Context;
using Janari0.Services.IServices;

namespace Janari0.Services.Services
{
    public class ProductsService : BaseCRUDService<Model.Product, Database.Product, ProductSearchObject, ProductInsertRequest, ProductUpdateRequest>, IProductsService
    {
        public ProductsService(Janari0Context context, IMapper mapper)
            : base(context, mapper) { }

        public override async Task<IEnumerable<Model.Product>> Get(ProductSearchObject? search = null)
        {
            var list = await base.Get(search);
            foreach (var product in list)
            {
                var photos = Context.Photos.Where(x => x.ProductId == product.ProductId).ToList();
                product.Photos = Mapper.Map<List<Photo>>(photos);
            }
            return Mapper.Map<IList<Product>>(list);
        }

        public override async Task<Model.Product?> GetById(int id)
        {
            var product = await base.GetById(id);

            var photos = Context.Photos.Where(x => x.ProductId == product.ProductId).ToList();
            product.Photos = Mapper.Map<List<Photo>>(photos);

            var user = Context.Users.Where(x => x.UserId == product.UserId).FirstOrDefault();
            product.User = Mapper.Map<User>(user);

            return Mapper.Map<Product>(product);
        }

        public override IQueryable<Database.Product> AddFilter(IQueryable<Database.Product> query, ProductSearchObject? search = null)
        {
            var filteredQuery = base.AddFilter(query, search);

            if (!string.IsNullOrWhiteSpace(search?.Uid))
            {
                filteredQuery = filteredQuery.Where(x => x.User.Uid == search.Uid);
            }
            if (!string.IsNullOrWhiteSpace(search?.Name))
            {
                filteredQuery = filteredQuery.Where(x => x.Name == search.Name);
            }
            string status = search?.ExpirationStatus ?? string.Empty;
            if (status != string.Empty)
            {
                if (status == "Expired")
                {
                    filteredQuery = filteredQuery.Where(x => x.ExpirationDate.CompareTo(DateTime.Now) < 0);
                }
                else
                {
                    filteredQuery = filteredQuery.Where(x => x.ExpirationDate.CompareTo(DateTime.Now) > 0);
                    if (status == "Within one week")
                    {
                        filteredQuery = filteredQuery.Where(x => x.ExpirationDate.CompareTo(DateTime.Now.AddDays(7)) < 0);
                    }
                }
            }
            return filteredQuery;
        }
    }
}
