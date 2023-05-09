using System;
using System.Collections.Generic;
using System.Text;

namespace Janari0.Model
{
    public class Order
    {
        public int OrderId { get; set; }

        public string OrderNumber { get; set; }

        public DateTime Date { get; set; }

        public bool Status { get; set; }

        public bool Canceled { get; set; }

        public int BuyerId { get; set; }

        public float Price { get; set; }

        public virtual Buyer Buyer { get; set; }

        public virtual ICollection<OrderItem> OrderItems { get; set; } = new List<OrderItem>();

        public virtual ICollection<Output> Outputs { get; set; } = new List<Output>();
    }
}
