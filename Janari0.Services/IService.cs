using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Janari0.Services
{
    public interface IService<T> where T : class
    {
        IEnumerable<T> Get();
    }
}
