using System;
using System.Collections.Generic;
using System.Text;

namespace Janari0.Model.SearchObjects
{
    public class ProductsSaleSearchObject : BaseSearchObject
    {
        public string Carousel { get; set; }
        public double Latitude { get; set; }
        public double Longitude { get; set; }
    }
}
