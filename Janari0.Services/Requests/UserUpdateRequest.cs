using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Janari0.Services.Requests
{
    public class UserUpdateRequest
    {
        public string? Username { get; set; }

        public string PhoneNumber { get; set; } = null!;

        public string? Geohash { get; set; }

        public float? Latitude { get; set; }

        public float? Longitude { get; set; }

        public string? Role { get; set; }
    }
}
