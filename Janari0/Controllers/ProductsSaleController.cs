using Janari0.Model.Requests;
using Janari0.Model.SearchObjects;
using Janari0.Services.IServices;
using Microsoft.AspNetCore.Mvc;

namespace Janari0.Controllers
{
    public class ProductsSaleController : BaseCRUDController<Model.ProductsSale, ProductsSaleSearchObject, ProductsSaleInsertRequest, ProductsSaleUpdateRequest>
    {
        public IProductsSaleService ProductsSaleService { get; set; }

        public ProductsSaleController(IProductsSaleService service)
            : base(service)
        {
            ProductsSaleService = service;
        }

        [HttpGet("GetCarouselData")]
        public async Task<IEnumerable<Model.ProductsSale>> GetCarouselData([FromQuery] ProductsSaleSearchObject? search = null)
        {
            return await ProductsSaleService.GetCarouselData(search);
        }

        [HttpGet("{id}/Recommend")]
        public async Task<List<Model.ProductsSale>> Recommend(int id)
        {
            return await ProductsSaleService.Recommend(id);
        }
    }
}
