using Janari0.Model.Requests;
using Janari0.Model.SearchObjects;
using Janari0.Services.IServices;

namespace Janari0.Controllers
{
    public class SellersController : BaseCRUDController<Model.Seller, SellerSearchObject, SellerInsertRequest, SellerUpdateRequest>
    {
        public SellersController(ISellersService sellerService) : base(sellerService)
        {
        }
    }
}
