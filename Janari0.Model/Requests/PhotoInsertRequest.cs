using Janari0.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Janari0.Services.Requests
{
    public class PhotoInsertRequest
    {
        public string Link { get; set; }

        public int? ProductId { get; set; }

        public virtual Product Product { get; set; }
    }
}
