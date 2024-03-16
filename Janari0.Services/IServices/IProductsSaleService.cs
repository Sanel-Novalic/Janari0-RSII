using Janari0.Model.Requests;
using Janari0.Model.SearchObjects;
using Microsoft.ML;

namespace Janari0.Services.IServices
{
    public interface IProductsSaleService : ICRUDService<Model.ProductsSale, ProductsSaleSearchObject, ProductsSaleInsertRequest, ProductsSaleUpdateRequest>
    {
        Task<IEnumerable<Model.ProductsSale>> GetCarouselData(ProductsSaleSearchObject? search = null);
        Task<List<Model.ProductsSale>> Recommend(int id);
    }
}
