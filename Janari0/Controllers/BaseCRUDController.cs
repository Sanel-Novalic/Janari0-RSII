using Janari0.Services;
using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;

namespace Janari0.Controllers
{
    public class BaseCRUDController<T, TInsert, TUpdate> : BaseController<T> where T : class where TInsert : class where TUpdate : class 
    {
        public BaseCRUDController(ICRUDService<T, TInsert, TUpdate> service) : base(service) { }

        [HttpPost]
        public T Insert([FromBody] TInsert insert)
        {
            var result = ((ICRUDService < T, TInsert, TUpdate >) this.Service).Insert(insert);  

            return result;
        }
        [HttpPut("{id}")]
        public T Update(int id, [FromBody] TUpdate update)
        {
            var result = ((ICRUDService<T, TInsert, TUpdate>)this.Service).Update(id, update);

            return result;
        }
    }
}
