using Janari0.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Janari0.Services.Requests
{
    public class ProductInsertRequest
    {
        public string Name { get; set; }
        public DateTime ExpirationDate { get; set; }
        public List<Photo> Photos { get; set; } = new List<Photo>();
        public int UserId { get; set; }
    }
}
