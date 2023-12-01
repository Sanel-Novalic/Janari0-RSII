using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Janari0.Services.Requests
{
    public class PhotoUpdateRequest
    {
        public string Link { get; set; }
        public int PhotoId { get; set; }
        public int? ProductId { get; set; }
    }
}
