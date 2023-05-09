using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace Janari0.Model.Requests
{
    public class OrderUpdateRequest
    {
        [Required(AllowEmptyStrings = false)]
        public bool Status { get; set; }
        [Required(AllowEmptyStrings = false)]
        public bool? Canceled { get; set; }
        public virtual List<OrderItemUpdateRequest> Items { get; set; }
    }
}
