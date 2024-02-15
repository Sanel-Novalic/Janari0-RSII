using System.ComponentModel.DataAnnotations;

namespace Janari0.Model.Requests
{
    public class OrderItemInsertRequest
    {
        [Required(AllowEmptyStrings = false)]
        public int OrderId { get; set; }

        [Required(AllowEmptyStrings = false)]
        public int ProductSaleId { get; set; }
    }
}
