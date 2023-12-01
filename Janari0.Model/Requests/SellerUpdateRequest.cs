using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace Janari0.Model.Requests
{
    public class SellerUpdateRequest
    {
        //PersonUpdateRequest
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
        public string Address { get; set; }
        [Required(AllowEmptyStrings = false)]
        public string PhoneNumber { get; set; }
        public string Website { get; set; }
        [Required(AllowEmptyStrings = false)]
        public string Email { get; set; }
        [Required(AllowEmptyStrings = false)]
        public bool Status { get; set; }
        [Required(AllowEmptyStrings = false)]
        public string Password { get; set; }
        [Required(AllowEmptyStrings = false)]
        public string PasswordConfirmation { get; set; }
        [Required(AllowEmptyStrings = false)]
        public string PayPalEmail { get; set; }
    }
}
