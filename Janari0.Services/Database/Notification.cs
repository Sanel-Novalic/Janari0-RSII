using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Janari0.Services.Database
{
    public partial class Notification
    {
        public int NotificationId { get; set; }
        public string NotificationDesc { get; set; } = null!;
        public DateTime NotificationDateTime { get; set; }
        public int BuyerId { get; set; }

        public virtual Buyer Buyer { get; set; } = null!;
    }
}
