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
        private readonly IOrderItemsService _orderItemsService;
        private readonly IBuyersService _buyersService;
        private readonly IOutputService _outputService;
        private readonly IOutputItemsService _outputItemsService;
        private readonly IUsersService _usersService;
        private readonly IEmailProviderService _emailProviderService;

        public OrdersService(
            Janari0Context context,
            IMapper mapper,
            IOrderItemsService orderItemsService,
            IBuyersService buyersService,
            IOutputService outputService,
            IOutputItemsService outputItemsService,
            IUsersService usersService,
            IEmailProviderService emailProviderService)
            : base(context, mapper)
        {
            _orderItemsService = orderItemsService;
            _buyersService = buyersService;
            _outputService = outputService;
            _outputItemsService = outputItemsService;
            _usersService = usersService;
            _emailProviderService = emailProviderService;
        }

        public override async Task<IEnumerable<Model.Order>> Get(OrderSearchObject? search = null)
        {
            var list = await base.Get(search);
            var result = new List<Model.Order>();
            BuyerSearchObject buyerSearchObject = new();
            buyerSearchObject.UserId = search!.UserId;
            var buyers = await _buyersService.Get(buyerSearchObject);
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
                var orderItems = await _orderItemsService.Get(orderItemSearchObject);
                item.OrderItems = orderItems.ToList();
            }
            return result;
        }

        public override async Task BeforeDelete(Order dbentity)
        {
            OutputSearchObject searchOutput = new OutputSearchObject() { OrderId = dbentity.OrderId };
            var outputs = await _outputService.Get(searchOutput);

            if (outputs.Count() > 0)
            {
                OutputItemSearchObject searchOutputItem = new OutputItemSearchObject() { OutputId = outputs.FirstOrDefault().OutputId };
                var outputItems = await _outputItemsService.Get(searchOutputItem);
                foreach (var item in outputItems)
                {
                    await _outputItemsService.Delete(item.OutputItemId);
                }

                outputs = await _outputService.Get(searchOutput);

                foreach (var item in outputs)
                {
                    if (item.OutputItems.Count == 0)
                        await _outputService.Delete(item.OutputId);
                }
            }
            var orderItemsSearch = new OrderItemSearchObject() { OrderId = dbentity.OrderId };
            var orderItems = await _orderItemsService.Get(orderItemsSearch);

            foreach (var orderItem in orderItems)
            {
                await _orderItemsService.Delete(orderItem.OrderItemId);
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

            if (insert.Items.Count() > 0)
            {
                foreach (var item in insert.Items)
                {
                    OrderItemInsertRequest dbitem = new OrderItemInsertRequest();
                    dbitem.OrderId = result.OrderId;
                    dbitem.ProductSaleId = item.ProductSaleId;

                    await _orderItemsService.Insert(dbitem);
                }
            }

            if (result != null)
            {
                var buyer = await _buyersService.GetById(insert.BuyerId);

                var user = await _usersService.GetById(buyer.UserId);

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
