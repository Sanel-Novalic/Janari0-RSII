using Janari0.Services;
using Janari0.Services.Requests;
using Microsoft.AspNetCore.Mvc;

namespace Janari0.Controllers
{
    public class ProductsController : BaseCRUDController<Model.Product, ProductInsertRequest, ProductUpdateRequest>
    {
        public ProductsController(IProductsService service): base(service)
        {
        }
    }
}
