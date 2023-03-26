using Janari0.Services.Requests;

namespace Janari0.Services
{
    public interface IProductsService : ICRUDService<Model.Product, ProductInsertRequest, ProductUpdateRequest>
    {

    }
}
