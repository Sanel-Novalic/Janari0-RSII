using System;
using System.ComponentModel.DataAnnotations;

namespace Janari0.Model.Requests
{
    public class BuyerUpdateRequest
    {
        [Required(AllowEmptyStrings = false)]
        public string FirstName { get; set; }

        [Required(AllowEmptyStrings = false)]
        public string LastName { get; set; }

        [Required(AllowEmptyStrings = false)]
        public DateTime DateOfBirth { get; set; }

        [Required(AllowEmptyStrings = false)]
        public string Gender { get; set; }

        //----------------------------------
        [Required(AllowEmptyStrings = false)]
        public string Email { get; set; }

        [Required(AllowEmptyStrings = false)]
        public string Password { get; set; }

        [Required(AllowEmptyStrings = false)]
        public string PasswordConfirmation { get; set; }
        public bool Status { get; set; }
    }
}
