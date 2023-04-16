using Janari0.Model.SearchObjects;
using Janari0.Services.IServices;
using Microsoft.AspNetCore.Mvc;

namespace Janari0.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class BaseController<T, TSearch> : ControllerBase where T : class where TSearch : BaseSearchObject
    {
        public IService<T, TSearch> Service { get; set; }

        public BaseController(IService<T, TSearch> service)
        {
            Service = service;
        }
        [HttpGet]
        public virtual IEnumerable<T> Get([FromQuery] TSearch search = null)
        {
            return Service.Get(search);
        }
        [HttpGet("{id}")]
        public virtual T GetById(int id)
        {
            return Service.GetById(id);
        }
    }
}
