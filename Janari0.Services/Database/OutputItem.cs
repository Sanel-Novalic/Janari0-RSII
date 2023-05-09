using System;
using System.Collections.Generic;

namespace Janari0.Services.Database;

public partial class OutputItem
{
    public int OutputItemId { get; set; }

    public int? OutputId { get; set; }

    public int? ProductSaleId { get; set; }

    public float? Price { get; set; }

    public int? SellerId { get; set; }

    public virtual Output? Output { get; set; }

    public virtual ProductsSale? ProductSale { get; set; }

    public virtual Seller? Seller { get; set; }
}
