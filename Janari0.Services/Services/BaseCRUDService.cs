using AutoMapper;
using Janari0.Model.SearchObjects;
using Janari0.Services.Context;
using Janari0.Services.IServices;
using Microsoft.EntityFrameworkCore;

namespace Janari0.Services.Services
{
    public class BaseCRUDService<T, Tdb, TSearch, TInsert, TUpdate> : BaseService<T, Tdb, TSearch>, ICRUDService<T, TSearch, TInsert, TUpdate>
        where T : class
        where Tdb : class
        where TSearch : BaseSearchObject
        where TInsert : class
        where TUpdate : class
    {
        public BaseCRUDService(Janari0Context context, IMapper mapper)
            : base(context, mapper) { }

        public virtual async Task<T?> Insert(TInsert insert)
        {
            var set = Context.Set<Tdb>();

            Tdb entity = Mapper.Map<Tdb>(insert);

            set.Add(entity);

            await BeforeInsert(insert, entity);

            await Context.SaveChangesAsync();

            return Mapper.Map<T>(entity);
        }

        public virtual async Task BeforeInsert(TInsert insert, Tdb dbentity) { }

        public virtual async Task BeforeUpdate(TUpdate update, Tdb dbentity) { }

        public virtual async Task<T?> Update(int id, TUpdate update)
        {
            var set = Context.Set<Tdb>();

            var entity = await set.FindAsync(id);

            if (entity != null)
            {
                Mapper.Map(update, entity);
            }
            else
            {
                return null;
            }

            Context.Entry(entity).State = EntityState.Modified;

            await Context.SaveChangesAsync();

            return Mapper.Map<T>(entity);
        }

        public virtual async Task BeforeDelete(Tdb dbentity) { }

        public virtual async Task AfterDelete(Tdb dbentity) { }

        public virtual async Task<T?> Delete(int id)
        {
            var set = Context.Set<Tdb>();

            var dbentity = await set.FindAsync(id);

            if (dbentity == null)
            {
                return null;
            }

            var deletedEntity = dbentity;

            await BeforeDelete(deletedEntity);

            set.Remove(dbentity);

            await AfterDelete(deletedEntity);

            await Context.SaveChangesAsync();

            return Mapper.Map<T>(deletedEntity);
        }
    }
}
