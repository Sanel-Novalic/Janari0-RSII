using Janari0.Model.SearchObjects;
using Janari0.Services.IServices;
using Janari0.Services.Requests;
using Janari0.Services.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Stripe;

namespace Janari0.Controllers
{
    public class ProductsSaleController : BaseCRUDController<Model.ProductsSale, ProductsSaleSearchObject, ProductsSaleInsertRequest, ProductsSaleInsertRequest>
    {
        public IProductsSaleService ProductsSaleService { get; set; }
        public ProductsSaleController(IProductsSaleService service): base(service)
        {
            ProductsSaleService = service;
        }

        [HttpGet("GetCarouselData")]
        public IEnumerable<Model.ProductsSale> GetCarouselData([FromQuery] ProductsSaleSearchObject? search = null)
        {
            return ProductsSaleService.GetCarouselData(search);
        }

        [HttpGet("{id}/Recommend")]
        public List<Model.ProductsSale> Recommend(int id)
        {
            return ProductsSaleService.Recommend(id);
        }
    }
}
