using System;
using System.Collections.Generic;

namespace Janari0.Services.Database;

public partial class ProductsSale
{
    public int ProductSaleId { get; set; }

    public string? Description { get; set; }

    public string? Price { get; set; }

    public int LocationId { get; set; }

    public int ProductId { get; set; }

    public virtual ICollection<Buyer> Buyers { get; } = new List<Buyer>();

    public virtual Location? Location { get; set; }

    public virtual ICollection<OrderItem> OrderItems { get; } = new List<OrderItem>();

    public virtual ICollection<OutputItem> OutputItems { get; } = new List<OutputItem>();

    public virtual Product? Product { get; set; }

    public virtual ICollection<Seller> Sellers { get; } = new List<Seller>();
}
