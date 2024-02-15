using Janari0.Model.Requests;
using Janari0.Model.SearchObjects;

namespace Janari0.Services.IServices
{
    public interface IBuyersService : ICRUDService<Model.Buyer, BuyerSearchObject, BuyerInsertRequest, BuyerUpdateRequest> { }
}
