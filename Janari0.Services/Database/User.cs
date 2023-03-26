using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace Janari0.Services.Database;

public partial class User
{
    [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
    [Key]
    public int UserId { get; set; }

    public string? Username { get; set; }

    public string PhoneNumber { get; set; } = null!;

    public string? Geohash { get; set; }

    public float? Latitude { get; set; }

    public float? Longitude { get; set; }

    public string? Role { get; set; }

    public string? Email { get; set; }
}
