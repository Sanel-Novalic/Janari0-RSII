using System;
using System.Collections.Generic;

namespace Janari0.Services.Database;

public partial class OrderItem
{
    public int OrderItemId { get; set; }

    public int? OrderId { get; set; }

    public int? ProductSaleId { get; set; }

    public virtual Order? Order { get; set; }

    public virtual ProductsSale? ProductSale { get; set; }
}
