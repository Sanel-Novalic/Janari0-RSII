using Janari0.Model.Requests;
using Janari0.Model.SearchObjects;
using Janari0.Services.IServices;

namespace Janari0.Controllers
{
    public class BuyersController : BaseCRUDController<Model.Buyer, BuyerSearchObject, BuyerInsertRequest, BuyerUpdateRequest>
    {
        public BuyersController(IBuyersService buyersService)
            : base(buyersService)
        {
        }
    }
}
