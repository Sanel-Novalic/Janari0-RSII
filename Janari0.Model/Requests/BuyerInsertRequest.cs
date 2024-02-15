using System.ComponentModel.DataAnnotations;

namespace Janari0.Model.Requests
{
    public class BuyerInsertRequest
    {
        public int UserId { get; set; }

        [Required(AllowEmptyStrings = false)]
        public bool Status { get; set; }
    }
}
