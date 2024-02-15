using AutoMapper;
using EasyNetQ;
using Janari0.Model.Requests;
using Janari0.Model.SearchObjects;
using Janari0.Services.Context;
using Janari0.Services.Database;
using Janari0.Services.IServices;

namespace Janari0.Services.Services
{
    public class OrdersService : BaseCRUDService<Model.Order, Database.Order, OrderSearchObject, OrderInsertRequest, OrderUpdateRequest>, IOrdersService
    {
        public OrdersService(Janari0Context context, IMapper mapper)
            : base(context, mapper) { }

        public override async Task<IEnumerable<Model.Order>> Get(OrderSearchObject? search = null)
        {
            var list = await base.Get(search);
            var result = new List<Model.Order>();
            BuyersService buyersService = new(Context, Mapper);
            OrderItemsService orderItemsService = new(Context, Mapper);
            BuyerSearchObject buyerSearchObject = new();
            buyerSearchObject.UserId = search!.UserId;
            var buyers = await buyersService.Get(buyerSearchObject);
            foreach (var item in list)
            {
                if (buyers.Any(x => x.BuyerId == item.BuyerId))
                {
                    result.Add(item);
                }
            }
            foreach (var item in result)
            {
                OrderItemSearchObject orderItemSearchObject = new();
                orderItemSearchObject.OrderId = item.OrderId;
                var orderItems = await orderItemsService.Get(orderItemSearchObject);
                item.OrderItems = orderItems.ToList();
            }
            return result;
        }

        public override async Task BeforeDelete(Order dbentity)
        {
            var orderService = new OrderItemsService(Context, Mapper);
            var orderItemsService = new OrderItemsService(Context, Mapper);
            var outputService = new OutputService(Context, Mapper);
            var outputItemsService = new OutputItemsService(Context, Mapper);
            OutputSearchObject searchOutput = new OutputSearchObject() { OrderId = dbentity.OrderId };
            var outputs = await outputService.Get(searchOutput);

            if (outputs.Count() > 0)
            {
                OutputItemSearchObject searchOutputItem = new OutputItemSearchObject() { OutputId = outputs.FirstOrDefault().OutputId };
                var outputItems = await outputItemsService.Get(searchOutputItem);
                foreach (var item in outputItems)
                {
                    await outputItemsService.Delete(item.OutputItemId);
                }

                outputs = await outputService.Get(searchOutput);

                foreach (var item in outputs)
                {
                    if (item.OutputItems.Count == 0)
                        await outputService.Delete(item.OutputId);
                }
            }
            var orderItemsSearch = new OrderItemSearchObject() { OrderId = dbentity.OrderId };
            var orderItems = await orderItemsService.Get(orderItemsSearch);

            foreach (var orderItem in orderItems)
            {
                await orderService.Delete(orderItem.OrderItemId);
            }

            await base.BeforeDelete(dbentity);
        }

        public override async Task BeforeInsert(OrderInsertRequest insert, Order dbentity)
        {
            dbentity.Date = DateTime.Now;
            dbentity.OrderNumber = (Context.Orders.Count() + 1).ToString();
            await base.BeforeInsert(insert, dbentity);
        }

        public override async Task<Model.Order?> Insert(OrderInsertRequest insert)
        {
            var result = await base.Insert(insert);

            OrderItemsService orderItemsService = new OrderItemsService(Context, Mapper);

            if (insert.Items.Count() > 0)
            {
                foreach (var item in insert.Items)
                {
                    OrderItemInsertRequest dbitem = new OrderItemInsertRequest();
                    dbitem.OrderId = result.OrderId;
                    dbitem.ProductSaleId = item.ProductSaleId;

                    await orderItemsService.Insert(dbitem);
                }
            }

            if (result != null)
            {
                BuyersService buyersService = new BuyersService(Context, Mapper);

                var buyer = await buyersService.GetById(insert.BuyerId);

                UsersService usersService = new UsersService(Context, Mapper);

                var user = await usersService.GetById(buyer.UserId);

                var emailMessage = new Model.EmailMessage
                {
                    To = user.Email,
                    TrackNumber = result.OrderId.ToString(),
                    Date = result.Date.ToString()
                };

                EmailProviderService emailProviderService = new EmailProviderService();

                await emailProviderService.SendMessage(emailMessage, "email");
            }
            return result;
        }
    }
}
