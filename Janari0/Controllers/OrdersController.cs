using Janari0.Model.Requests;
using Janari0.Model.SearchObjects;
using Janari0.Services.IServices;

namespace Janari0.Controllers
{
    public class OrdersController : BaseCRUDController<Model.Order, OrderSearchObject, OrderInsertRequest, OrderUpdateRequest>
    {
        public OrdersController(IOrdersService orderService) : base(orderService)
        {
        }
    }
}
