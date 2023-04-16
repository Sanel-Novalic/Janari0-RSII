using Janari0.Model.SearchObjects;
using Janari0.Services.Requests;

namespace Janari0.Services.IServices
{
    public interface IProductsSaleService : ICRUDService<Model.ProductsSale, ProductsSaleSearchObject, ProductsSaleInsertRequest, ProductsSaleInsertRequest>
    {
    }
}
