using System;
using System.Collections.Generic;

namespace Janari0.Services.Database;

public partial class Location
{
    public int LocationId { get; set; }

    public string Geohash { get; set; } = null!;

    public decimal Latitude { get; set; }

    public decimal Longitude { get; set; }
}
