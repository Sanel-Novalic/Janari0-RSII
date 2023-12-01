using System;
using System.Collections.Generic;
using System.Text;

namespace Janari0.Model.SearchObjects
{
    public class SellerSearchObject : BaseSearchObject
    {
        public string Name { get; set; }
        public string Address { get; set; }
        public string PhoneNumber { get; set; }
        public string Email { get; set; }
        public bool Status { get; set; }
    }
}
