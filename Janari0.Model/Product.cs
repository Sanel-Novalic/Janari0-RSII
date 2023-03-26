using System;

namespace Janari0.Model
{
    public partial class Product
    {
        public int ProductId { get; set; }

        public string Name { get; set; }

        public DateTime ExpirationDate { get; set; }

        public int PhotosId { get; set; }
    }
}
