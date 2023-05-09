using System;
using System.Collections.Generic;
using System.Text;

namespace Janari0.Model
{
    public partial class Location
    {
        public double Latitude { get; set; }

        public double Longitude { get; set; }

        public int LocationId { get; set; }

        public virtual ICollection<ProductsSale> ProductsSales { get; } = new List<ProductsSale>();

        public virtual ICollection<User> Users { get; } = new List<User>();
    }
}
