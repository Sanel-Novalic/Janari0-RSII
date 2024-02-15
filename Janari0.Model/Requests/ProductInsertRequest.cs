using System;
using System.Collections.Generic;

namespace Janari0.Model.Requests
{
    public class ProductInsertRequest
    {
        public string Name { get; set; }
        public DateTime ExpirationDate { get; set; }
        public List<Photo> Photos { get; set; } = new List<Photo>();
        public int UserId { get; set; }
    }
}
