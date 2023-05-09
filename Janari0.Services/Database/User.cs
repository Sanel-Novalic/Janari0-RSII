using System;
using System.Collections.Generic;

namespace Janari0.Services.Database;

public partial class User
{
    public string Username { get; set; } = null!;

    public string? PhoneNumber { get; set; }

    public string? Role { get; set; }

    public string Email { get; set; } = null!;

    public int? LocationId { get; set; }

    public int UserId { get; set; }

    public string? Uid { get; set; }

    public virtual ICollection<Buyer> Buyers { get; } = new List<Buyer>();

    public virtual Location? Location { get; set; }

    public virtual ICollection<Product> Products { get; } = new List<Product>();

    public virtual ICollection<Seller> Sellers { get; } = new List<Seller>();
}
