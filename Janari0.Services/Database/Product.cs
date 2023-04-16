using System;
using System.Collections.Generic;

namespace Janari0.Services.Database;

public partial class Product
{
    public string Name { get; set; } = null!;

    public DateTime ExpirationDate { get; set; }

    public int ProductId { get; set; }

    public int UserId { get; set; }

    public virtual ICollection<Photo> Photos { get; } = new List<Photo>();

    public virtual ICollection<ProductsSale> ProductsSales { get; } = new List<ProductsSale>();

    public virtual User User { get; set; } = null!;
}
