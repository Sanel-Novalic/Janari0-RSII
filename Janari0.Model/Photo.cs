using System;
using System.Collections.Generic;
using System.Text;

namespace Janari0.Model
{
    public partial class Photo
    {
        public string Link { get; set; }

        public int PhotoId { get; set; }

        public int? ProductId { get; set; }

        public virtual Product Product { get; set; }
    }
}
