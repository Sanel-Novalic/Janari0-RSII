using Janari0.Model.SearchObjects;
using Janari0.Services.IServices;
using Janari0.Services.Requests;

namespace Janari0.Controllers
{
    public class ProductsController : BaseCRUDController<Model.Product, ProductSearchObject, ProductInsertRequest, ProductUpdateRequest>
    {
        public ProductsController(IProductsService service): base(service)
        {
        }
    }
}
