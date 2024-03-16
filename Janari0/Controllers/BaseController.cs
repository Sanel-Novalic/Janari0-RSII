using Janari0.Model.SearchObjects;
using Janari0.Services.IServices;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace Janari0.Controllers
{
    [ApiController]
    [Route("[controller]")]
    [Authorize]
    public class BaseController<T, TSearch> : ControllerBase
        where T : class
        where TSearch : BaseSearchObject
    {
        public IService<T, TSearch> Service { get; set; }

        public BaseController(IService<T, TSearch> service)
        {
            Service = service;
        }

        [HttpGet]
        public async Task<IEnumerable<T?>> Get([FromQuery] TSearch? search = null)
        {
            return await Service.Get(search);
        }

        [HttpGet("{id}")]
        public virtual async Task<T?> GetById(int id)
        {
            return await Service.GetById(id);
        }
    }
}