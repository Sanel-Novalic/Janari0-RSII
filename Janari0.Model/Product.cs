using System;
using System.Collections.Generic;

namespace Janari0.Model
{
    public partial class Product
    {
        public int ProductId { get; set; }
        public string Name { get; set; }
        public DateTime ExpirationDate { get; set; }
        public int UserId { get; set; }
        public virtual List<Photo> Photos { get; set; } = new List<Photo>();
        public virtual ProductsSale ProductsSale { get; set; }
        public virtual User User { get; set; }
    }
}
