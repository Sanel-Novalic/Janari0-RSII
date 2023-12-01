using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace Janari0.Model.Requests
{
    public class OrderItemUpdateRequest
    {
        [Required(AllowEmptyStrings = false)]
        public int ProductSaleId { get; set; }
    }
}
