using Janari0.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Janari0.Services.Requests
{
    public class UserInsertRequest
    {
        public string Uid { get; set; }
        public string Username { get; set; }

        public string Email { get; set; }

        public string PhoneNumber { get; set; }

        public Location Location { get; set; }
        //
        //public string? Role { get; set; }
    }
}
