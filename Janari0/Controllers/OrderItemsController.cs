using Janari0.Model.SearchObjects;
using Janari0.Model.Requests;
using Janari0.Services.IServices;

namespace Janari0.Controllers
{
    public class OrderItemsController : BaseCRUDController<Model.OrderItem, OrderItemSearchObject, OrderItemInsertRequest, OrderItemUpdateRequest>
    {
        public OrderItemsController(IOrderItemsService orderItemsService) : base(orderItemsService)
        {
        }
    }
}
