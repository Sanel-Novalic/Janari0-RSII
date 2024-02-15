using System.ComponentModel.DataAnnotations;

namespace Janari0.Model.Requests
{
    public class OrderItemUpdateRequest
    {
        [Required(AllowEmptyStrings = false)]
        public int ProductSaleId { get; set; }
    }
}
