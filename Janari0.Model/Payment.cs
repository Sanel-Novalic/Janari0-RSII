using System;
using System.Collections.Generic;
using System.Text;

namespace Janari0.Model
{
    public class Payment
    {
        public string PaymentMethodNonce { get; set; }
        public decimal Amount { get; set; }
        public bool Successful { get; set; }
        public int ProductSaleId { get; set; }
        public int BuyerId { get; set; }
    }
}
