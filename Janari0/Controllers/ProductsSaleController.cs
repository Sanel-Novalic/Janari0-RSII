using Janari0.Model.SearchObjects;
using Janari0.Services.IServices;
using Janari0.Services.Requests;
using Microsoft.AspNetCore.Mvc;

namespace Janari0.Controllers
{
    public class ProductsSaleController : BaseCRUDController<Model.ProductsSale, ProductsSaleSearchObject, ProductsSaleInsertRequest, ProductsSaleInsertRequest>
    {
        public ProductsSaleController(IProductsSaleService service): base(service)
        {
        }
    }
}
