namespace Janari0.Model.Requests
{
    public class OutputUpdateRequest
    {
        public string PaymentMethod { get; set; }
        public bool Concluded { get; set; }
        public decimal Amount { get; set; }
    }
}
