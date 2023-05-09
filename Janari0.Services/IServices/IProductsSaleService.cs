using Janari0.Model.SearchObjects;
using Janari0.Services.Requests;
using Microsoft.ML;

namespace Janari0.Services.IServices
{
    public interface IProductsSaleService : ICRUDService<Model.ProductsSale, ProductsSaleSearchObject, ProductsSaleInsertRequest, ProductsSaleInsertRequest>
    {
        IEnumerable<Model.ProductsSale> GetCarouselData(ProductsSaleSearchObject? search = null);
        List<Model.ProductsSale> Recommend(int id);
        ITransformer ModelTrainer(int id);
    }
}
