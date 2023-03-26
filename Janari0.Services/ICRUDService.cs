using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Janari0.Services
{
    public interface ICRUDService<T, TInsert, TUpdate> : IService<T> where T : class where TInsert : class where TUpdate : class
    {
        T Insert(TInsert insert);

        T Update(int id, TUpdate update);
    }
}
