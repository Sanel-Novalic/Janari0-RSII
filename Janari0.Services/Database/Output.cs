using System;
using System.Collections.Generic;

namespace Janari0.Services.Database;

public partial class Output
{
    public int OutputId { get; set; }

    public DateTime? Date { get; set; }

    public string? PaymentMethod { get; set; }

    public bool? Concluded { get; set; }

    public float? Amount { get; set; }

    public string? ReceiptNumber { get; set; }

    public int? BuyerId { get; set; }

    public int? OrderId { get; set; }

    public virtual Buyer? Buyer { get; set; }

    public virtual Order? Order { get; set; }

    public virtual ICollection<OutputItem> OutputItems { get; } = new List<OutputItem>();
}
