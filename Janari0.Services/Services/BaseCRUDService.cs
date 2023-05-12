using AutoMapper;
using Janari0.Model.SearchObjects;
using Janari0.Services.Context;
using Janari0.Services.IServices;
using Microsoft.EntityFrameworkCore;

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

        //BeforeInsert is for some specific operations we need to do before inserting into the database
        public virtual void BeforeInsert(TInsert insert, Tdb dbentity)
        {

        }
        //BeforeUpdate is for some specific operations we need to do before updating the database
        public virtual void BeforeUpdate(TUpdate update, Tdb dbentity)
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
            Context.Entry(entity).State = EntityState.Modified;

            Context.SaveChanges();

            return Mapper.Map<T>(entity);

        }
        //BeforeDelete is for some specific operations we need to do before deleting the object from databse
        public virtual void BeforeDelete(Tdb dbentity)
        {

        }
        public virtual void AfterDelete(Tdb dbentity)
        {

        }
        public virtual T? Delete(int id)
        {
            var set = Context.Set<Tdb>();

            var dbentity = set.Find(id);

            if (dbentity == null)
            {
                return null;
            }

            var deletedEntity = dbentity;

            BeforeDelete(deletedEntity);

            set.Remove(dbentity);
            AfterDelete(deletedEntity);

            Context.SaveChanges();

            return Mapper.Map<T>(deletedEntity);
        }
    }
}
