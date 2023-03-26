using AutoMapper;
using Janari0.Services.Database;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Janari0.Services
{
    public class BaseService<T, TDb> : IService<T> where T : class where TDb : class
    {
        public Janari0Context Context { get; set; } 
        public IMapper Mapper { get; set; }
        public BaseService(Janari0Context context, IMapper mapper)
        {
            Context = context;
            Mapper = mapper;
        }
        public IEnumerable<T> Get()
        {
            var entity = Context.Set<TDb>();
             
            var list = entity.ToList();

            return Mapper.Map<IList<T>>(list);
        }
    }
}
