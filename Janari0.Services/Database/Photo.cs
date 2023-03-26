using System;
using System.Collections.Generic;

namespace Janari0.Services.Database;

public partial class Photo
{
    public int PhotoId { get; set; }

    public int PhotosId { get; set; }

    public string? Link { get; set; }
}
