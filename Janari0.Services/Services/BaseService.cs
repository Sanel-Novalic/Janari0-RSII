﻿using AutoMapper;
using Janari0.Model.SearchObjects;
using Janari0.Services.Context;
using Janari0.Services.IServices;
using Microsoft.EntityFrameworkCore;

namespace Janari0.Services.Services
{
    public class BaseService<T, TDb, TSearch> : IService<T, TSearch>
        where T : class
        where TDb : class
        where TSearch : BaseSearchObject
    {
        public Janari0Context Context { get; set; }
        public IMapper Mapper { get; set; }

        public BaseService(Janari0Context context, IMapper mapper)
        {
            Context = context;
            Mapper = mapper;
        }

        public virtual async Task<IEnumerable<T>> Get(TSearch? search = null)
        {
            var entity = Context.Set<TDb>().AsQueryable();

            entity = AddFilter(entity, search);

            entity = AddInclude(entity, search);

            if (search?.Page.HasValue == true && search?.PageSize.HasValue == true)
            {
                entity = entity.Take(search.PageSize.Value).Skip(search.Page.Value * search.PageSize.Value);
            }

            var list = await entity.ToListAsync();

            return Mapper.Map<IList<T>>(list);
        }

        public virtual IQueryable<TDb> AddInclude(IQueryable<TDb> query, TSearch? search = null)
        {
            return query;
        }

        public virtual IQueryable<TDb> AddFilter(IQueryable<TDb> query, TSearch? search = null)
        {
            return query;
        }

        public virtual async Task<T?> GetById(int id)
        {
            var entity = await Context.Set<TDb>().FindAsync(id);

            return Mapper.Map<T>(entity);
        }
    }
}
