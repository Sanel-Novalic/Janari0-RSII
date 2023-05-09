using System;
using System.Collections.Generic;
using System.Text;

namespace Janari0.Services.Requests
{
    public class OutputUpsertRequest
    {
        public DateTime Date { get; set; }
        public string PaymentMethod { get; set; }
        public int BuyerId { get; set; }
        public bool Concluded { get; set; }
        public decimal Amount { get; set; }
        public int OrderId { get; set; }
        public string ReceiptNumber { get; set; }
    }
}
