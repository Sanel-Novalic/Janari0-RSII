using Janari0.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Janari0.Services.Requests
{
    public class ProductsSaleInsertRequest
    {
        public string Description { get; set; }

        public string Price { get; set; }

        public int ProductId { get; set; }
    }
}
