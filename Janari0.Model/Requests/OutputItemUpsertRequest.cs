namespace Janari0.Model.Requests
{
    public class OutputItemUpsertRequest
    {
        public int OutputId { get; set; }
        public int ProductId { get; set; }
        public decimal Price { get; set; }
        public decimal? Discount { get; set; }
        public int SellerId { get; set; }
    }
}
