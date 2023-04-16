using System;
using System.Collections.Generic;
using System.Text;

namespace Janari0.Model
{
    public partial class ProductsSale
    {
        public int ProductsSaleId { get; set; }

        public string Description { get; set; }

        public string Price { get; set; }

        public int? LocationId { get; set; }

        public int ProductId { get; set; }

        public virtual Location Location { get; set; }

        public virtual Model.Product Product { get; set; }
    }

}
