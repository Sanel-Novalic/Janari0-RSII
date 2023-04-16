using System;
using System.Collections.Generic;
using System.Text;

namespace Janari0.Model
{
    public partial class User
    {
        public int UserId { get; set; }

        public string Username { get; set; }

        public string PhoneNumber { get; set; }

        public string Role { get; set; }

        public string Email { get; set; }

        public int? LocationId { get; set; }
        
        public string Uid { get; set; }

        public virtual Location Location { get; set; }

        public virtual ICollection<Product> Products { get; } = new List<Product>();
    }
}
