namespace Janari0.Model.Requests
{
    public class ProductsSaleInsertRequest
    {
        public int ProductId { get; set; }
        public string Description { get; set; }
        public string Price { get; set; }
        public int LocationId { get; set; }
    }
}
