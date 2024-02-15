using Janari0.Model.Requests;
using Janari0.Model.SearchObjects;

namespace Janari0.Services.IServices
{
    public interface IProductsService : ICRUDService<Model.Product, ProductSearchObject, ProductInsertRequest, ProductUpdateRequest> { }
}
