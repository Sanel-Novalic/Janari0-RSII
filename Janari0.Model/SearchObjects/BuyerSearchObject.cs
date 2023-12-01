using System;
using System.Collections.Generic;
using System.Text;

namespace Janari0.Model.SearchObjects
{
    public class BuyerSearchObject : BaseSearchObject
    {
        public int UserId { get; set; }
        public string Email { get; set; }
        public string Username { get; set; }
    }
}
