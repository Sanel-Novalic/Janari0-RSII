namespace Janari0.Model.Requests
{
    public class PhotoInsertRequest
    {
        public string Link { get; set; }
        public int? ProductId { get; set; }
        public virtual Product Product { get; set; }
    }
}
