using Janari0.Model.SearchObjects;
using Janari0.Services.IServices;
using Janari0.Services.Services;
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
        public virtual async Task<IActionResult> Insert([FromBody] TInsert insert)
        {
            try
            {
                var result = await ((ICRUDService<T, TSearch, TInsert, TUpdate>)this.Service).Insert(insert);
                return Ok(result);
            }
            catch (ArgumentException ex)
            {
                return BadRequest(new { error = ex.Message });
            }
            catch (Exception)
            {
                return StatusCode(500, new { error = "An error occurred while creating the user. Please try again." });
            }

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
