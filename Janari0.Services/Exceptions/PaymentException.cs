using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Janari0.Services.Exceptions
{
    public class PaymentException : Exception
    {
        public PaymentException(string message) : base(message)
        {

        }

    }
}
