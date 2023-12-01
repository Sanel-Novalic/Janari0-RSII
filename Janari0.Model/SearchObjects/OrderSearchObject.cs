using System;
using System.Collections.Generic;
using System.Text;

namespace Janari0.Model.SearchObjects
{
    public class OrderSearchObject : BaseSearchObject
    {
        public string OrderNumber { get; set; }
        public string BuyerName { get; set; }
        public DateTime Date { get; set; }
        public bool? Canceled { get; set; }
        public int UserId { get; set; }
    }
}
