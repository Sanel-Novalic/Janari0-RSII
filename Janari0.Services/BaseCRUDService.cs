using AutoMapper;
using Janari0.Services.Database;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Janari0.Services
{
    public class BaseCRUDService<T, Tdb, TInsert, TUpdate> : BaseService<T, Tdb> , ICRUDService<T, TInsert, TUpdate> where T : class where Tdb : class where TInsert : class where TUpdate : class
    {
        public BaseCRUDService(Janari0Context context, IMapper mapper): base(context, mapper) { }

        public virtual T Insert(TInsert insert)
        {
            var set = Context.Set<Tdb>();

            Tdb entity = Mapper.Map<Tdb>(insert);

            set.Add(entity);
            Context.SaveChanges();

            return Mapper.Map<T>(entity);
        }

        public T Update(int id, TUpdate update)
        {
            var set = Context.Set<Tdb>();

            var entity = set.Find(id);

            if(entity != null) {
                Mapper.Map(update,entity);  
            }
            else
            {
                return null;
            }

            Context.SaveChanges(); 

            return Mapper.Map<T>(entity);
        }
    }
}
