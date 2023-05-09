using AutoMapper;
using Janari0.Model.Requests;
using Janari0.Model.SearchObjects;
using Janari0.Services.Context;
using Janari0.Services.Database;
using Janari0.Services.Exceptions;
using Janari0.Services.IServices;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Logging;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Janari0.Services.Services
{
    public class OrdersService : BaseCRUDService<Model.Order, Database.Order, OrderSearchObject, OrderInsertRequest, OrderUpdateRequest>, IOrdersService
    {
        public OrdersService(Janari0Context context, IMapper mapper) : base(context, mapper)
        {
        }
        public override IQueryable<Order> AddInclude(IQueryable<Order> query, OrderSearchObject search = null)
        {
            if (search?.IncludeBuyer == true)
            {
                query = query.Include(i => i.Buyer);

            }
            if (search?.IncludeItems == true)
            {
                query = query.Include("OrderItems.Product.ProductType");
                query = query.Include("OrderItems.Product.Seller");
            }

            return query;
        }

        public virtual IEnumerable<Model.Order> Get(OrderSearchObject? search = null)
        {
            var list = base.Get(search);
            var result = new List<Model.Order>();
            BuyersService buyersService = new(Context, Mapper);
            OrderItemsService orderItemsService = new(Context, Mapper);
            BuyerSearchObject buyerSearchObject = new();
            buyerSearchObject.UserId = search.UserId;
            var buyers = buyersService.Get(buyerSearchObject);
            foreach(var item in list)
            {
                if (buyers.Any(x => x.BuyerId == item.BuyerId))
                {
                    result.Add(item);
                }
            }
            foreach(var item in result)
            {
                OrderItemSearchObject orderItemSearchObject = new();
                orderItemSearchObject.OrderId = item.OrderId; 
                var orderItems = orderItemsService.Get(orderItemSearchObject);
                item.OrderItems = orderItems.ToList();
            }
            return result;
        }
        public override void BeforeDelete(Order dbentity)
        {

            var orderService = new OrderItemsService(Context, Mapper);
            var orderItemsService = new OrderItemsService(Context, Mapper);
            var outputService = new OutputService(Context, Mapper);
            var outputItemsService = new OutputItemsService(Context, Mapper);
            OutputSearchObject searchOutput = new OutputSearchObject() { OrderId = dbentity.OrderId, Include = true };
            var outputs = outputService.Get(searchOutput);

            if (outputs.Count() > 0)
            {
                OutputItemSearchObject searchOutputItem = new OutputItemSearchObject() { OutputId = outputs.FirstOrDefault().OutputId };
                var outputItems = outputItemsService.Get(searchOutputItem);
                foreach (var item in outputItems)
                {
                    outputItemsService.Delete(item.OutputItemId);
                }

                outputs = outputService.Get(searchOutput);

                foreach (var item in outputs)
                {
                    if (item.OutputItems.Count == 0)
                        outputService.Delete(item.OutputId);
                }
            }
            var orderItemsSearch = new OrderItemSearchObject() { OrderId = dbentity.OrderId };
            var orderItems = orderItemsService.Get(orderItemsSearch);

            foreach (var orderItem in orderItems)
            {
                orderService.Delete(orderItem.OrderItemId);
            }

            base.BeforeDelete(dbentity);
        }
        public override void BeforeInsert(OrderInsertRequest insert, Order dbentity)
        {
            dbentity.Date = DateTime.Now;
            dbentity.OrderNumber = (Context.Orders.Count() + 1).ToString();
            base.BeforeInsert(insert, dbentity);
        }
        public override Model.Order Insert(OrderInsertRequest insert)
        {
            var result = base.Insert(insert);

            OrderItemsService orderItemsService = new OrderItemsService(Context, Mapper);

            if (insert.Items.Count() > 0)
            {
                foreach (var item in insert.Items)
                {
                    OrderItemInsertRequest dbitem = new OrderItemInsertRequest();
                    dbitem.OrderId = result.OrderId;
                    dbitem.ProductSaleId = item.ProductSaleId;

                    orderItemsService.Insert(dbitem);
                }
            }

            return result;
        }
        //public override Model.Order Update(int id, OrderUpdateRequest update)
        //{
        //    var order = base.GetById(id);
        //    OrderItemsService orderItemsService = new OrderItemsService(Context, Mapper);
        //
        //    if (order != null)
        //    {
        //        var orderItems = Context.OrderItems.Where(w => w.OrderId == order.OrderId).ToList();
        //
        //        if (orderItems.FirstOrDefault() != null && update.Items != null)
        //        {
        //            foreach (var orderItem in orderItems)
        //            {
        //                foreach (var item in update.Items)
        //                {
        //                    if (orderItem.ProductId == item.ProductId)
        //                    {
        //                        OrderItemUpdateRequest dbitem = new OrderItemUpdateRequest();
        //                        dbitem.ProductId = item.ProductId;
        //                        orderItemsService.Update(orderItem.OrderItemId, dbitem);
        //                    }
        //                }
        //
        //            }
        //        }
        //        order = base.Update(order.OrderId, update);
        //    }
        //    return order;
        //}

    }
}
