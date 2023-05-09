using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace Janari0.Model.Requests
{
    public class BuyerInsertRequest
    {
        public int UserId { get; set; }
        public bool Status { get; set; }

    }
}
