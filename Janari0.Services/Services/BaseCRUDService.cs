using AutoMapper;
using Janari0.Model.SearchObjects;
using Janari0.Services.Context;
using Janari0.Services.IServices;

namespace Janari0.Services.Services
{
    public class BaseCRUDService<T, Tdb, TSearch, TInsert, TUpdate> : BaseService<T, Tdb, TSearch>, ICRUDService<T, TSearch, TInsert, TUpdate> where T : class where Tdb : class where TSearch : BaseSearchObject where TInsert : class where TUpdate : class
    {
        public BaseCRUDService(Janari0Context context, IMapper mapper) : base(context, mapper) { }

        public virtual T Insert(TInsert insert)
        {
            var set = Context.Set<Tdb>();

            Tdb entity = Mapper.Map<Tdb>(insert);

            set.Add(entity);

            BeforeInsert(insert, entity);

            Context.SaveChanges();

            return Mapper.Map<T>(entity);
        }

        public virtual void BeforeInsert(TInsert insert, Tdb entity)
        {

        }

        public virtual T? Update(int id, TUpdate update)
        {
            var set = Context.Set<Tdb>();

            var entity = set.Find(id);

            if (entity != null)
            {
                Mapper.Map(update, entity);
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
