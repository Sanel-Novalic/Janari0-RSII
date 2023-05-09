using System;
using System.Collections.Generic;
using System.Text;

namespace Janari0.Model
{
    public partial class Buyer
    {
        public int BuyerId { get; set; }

        public int ProductSaleId { get; set; }

        public int UserId { get; set; }

        public bool Status { get; set; }

        public virtual ICollection<Order> Orders { get; } = new List<Order>();

        public virtual ICollection<Output> Outputs { get; } = new List<Output>();

        public virtual ProductsSale ProductSale { get; set; }

        public virtual User User { get; set; }
    }
}
