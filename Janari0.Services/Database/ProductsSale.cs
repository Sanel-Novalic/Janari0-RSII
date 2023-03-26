using System;
using System.Collections.Generic;

namespace Janari0.Services.Database;

public partial class ProductsSale
{
    public int ProductDonateId { get; set; }

    public int ProductId { get; set; }

    public string? Description { get; set; }

    public string? Price { get; set; }

    public int LocationId { get; set; }

    public string? PhoneNumber { get; set; }
}
