using System;
using System.Collections.Generic;
using System.Text;

namespace Janari0.Model.SearchObjects
{
    public class OrderItemSearchObject : BaseSearchObject
    {
        public int OrderItemID { get; set; }
        public int OrderId { get; set; }
        public int ProductSaleId { get; set; }
    }
}
