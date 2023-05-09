using System;
using System.Collections.Generic;
using System.Text;

namespace Janari0.Model
{
    public partial class OrderItem
    {
        public int OrderItemId { get; set; }

        public int OrderId { get; set; }

        public int ProductSaleId { get; set; }

        public virtual Order Order { get; set; }

        public virtual ProductsSale ProductSale { get; set; }
    }
}
