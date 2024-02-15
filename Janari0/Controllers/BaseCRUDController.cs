using Janari0.Model.SearchObjects;
using Janari0.Services.IServices;
using Microsoft.AspNetCore.Mvc;

namespace Janari0.Controllers
{
    public class BaseCRUDController<T, TSearch, TInsert, TUpdate> : BaseController<T, TSearch>
        where T : class
        where TSearch : BaseSearchObject
        where TInsert : class
        where TUpdate : class
    {
        public BaseCRUDController(ICRUDService<T, TSearch, TInsert, TUpdate> service)
            : base(service) { }

        [HttpPost]
        public virtual async Task<T?> Insert([FromBody] TInsert insert)
        {
            var result = await ((ICRUDService<T, TSearch, TInsert, TUpdate>)this.Service).Insert(insert);

            return result;
        }

        [HttpPut("{id}")]
        public virtual async Task<T?> Update(int id, [FromBody] TUpdate update)
        {
            var result = await ((ICRUDService<T, TSearch, TInsert, TUpdate>)this.Service).Update(id, update);

            return result;
        }

        [HttpDelete("{id}")]
        public virtual async Task<T?> Delete(int id)
        {
            var result = await ((ICRUDService<T, TSearch, TInsert, TUpdate>)this.Service).Delete(id);

            return result;
        }
    }
}
