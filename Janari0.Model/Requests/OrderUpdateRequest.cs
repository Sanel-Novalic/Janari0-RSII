using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace Janari0.Model.Requests
{
    public class OrderUpdateRequest
    {
        public bool Status { get; set; }
        public bool? Canceled { get; set; }
    }
}
