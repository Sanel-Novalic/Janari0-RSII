using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace Janari0.Model.Requests
{
    public class OrderInsertRequest
    {
        public List<OrderItemInsertRequest> Items { get; set; } = new List<OrderItemInsertRequest>();
        [Required(AllowEmptyStrings = false)]
        public bool Status { get; set; }
        [Required(AllowEmptyStrings = false)]
        public bool? Canceled { get; set; }
        public int BuyerId { get; set; }
        public float Price { get; set; }

    }
}
