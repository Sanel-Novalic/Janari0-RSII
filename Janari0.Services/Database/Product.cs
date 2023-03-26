using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Janari0.Services.Database;

public partial class Product
{
    [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
    [Key]
    public int ProductId { get; set; }

    public string Name { get; set; } = null!;

    public DateTime ExpirationDate { get; set; }

    public int PhotosId { get; set; }
}
