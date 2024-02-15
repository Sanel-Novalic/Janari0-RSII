using AutoMapper;
using Janari0.Model.Requests;
using Janari0.Model.SearchObjects;
using Janari0.Services.Context;
using Janari0.Services.IServices;

namespace Janari0.Services.Services
{
    public class OrderItemsService : BaseCRUDService<Model.OrderItem, Database.OrderItem, OrderItemSearchObject, OrderItemInsertRequest, OrderItemUpdateRequest>, IOrderItemsService
    {
        public OrderItemsService(Janari0Context context, IMapper mapper)
            : base(context, mapper) { }
    }
}
