using System.ComponentModel.DataAnnotations;

namespace Janari0.Model.Requests
{
    public class UserInsertRequest
    {
        public string Uid { get; set; }

        [Required(AllowEmptyStrings = false)]
        public string Username { get; set; }

        [Required(AllowEmptyStrings = false)]
        public string Email { get; set; }

        [Required(AllowEmptyStrings = false)]
        public string PhoneNumber { get; set; }
        public Location Location { get; set; }
    }
}
