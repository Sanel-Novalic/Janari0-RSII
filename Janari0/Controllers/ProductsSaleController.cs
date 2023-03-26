using Janari0.Services;
using Microsoft.AspNetCore.Mvc;

namespace Janari0.Controllers
{
    public class ProductsSaleController : BaseController<Model.ProductsSale>
    {
        public ProductsSaleController(IProductsSaleService service): base(service)
        {
        }
    }
}
