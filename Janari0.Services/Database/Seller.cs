using System;
using System.Collections.Generic;

namespace Janari0.Services.Database;

public partial class Seller
{
    public int SellerId { get; set; }

    public int? ProductSaleId { get; set; }

    public int? UserId { get; set; }

    public bool? Status { get; set; }

    public string? PaypalEmail { get; set; }

    public virtual ICollection<OutputItem> OutputItems { get; } = new List<OutputItem>();

    public virtual ProductsSale? ProductSale { get; set; }

    public virtual User? User { get; set; }
}
