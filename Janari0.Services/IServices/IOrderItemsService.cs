using Janari0.Model.Requests;
using Janari0.Model.SearchObjects;

namespace Janari0.Services.IServices
{
    public interface IOrderItemsService : ICRUDService<Model.OrderItem, OrderItemSearchObject, OrderItemInsertRequest, OrderItemUpdateRequest> { }
}
