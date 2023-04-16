using System;
using System.Collections.Generic;

namespace Janari0.Services.Database;

public partial class Location
{
    public decimal Latitude { get; set; }

    public decimal Longitude { get; set; }

    public int LocationId { get; set; }

    public virtual ICollection<ProductsSale> ProductsSales { get; } = new List<ProductsSale>();

    public virtual ICollection<User> Users { get; } = new List<User>();
}
