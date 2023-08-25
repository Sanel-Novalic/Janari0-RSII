using Janari0.Model.SearchObjects;
using Janari0.Services.IServices;
using Janari0.Services.Requests;
using Microsoft.AspNetCore.Mvc;

namespace Janari0.Controllers
{
    public class UsersController : BaseCRUDController<Model.User, UserSearchObject, UserInsertRequest, UserUpdateRequest>
    {
        public IUsersService UsersService { get; set; }
        public UsersController(IUsersService service): base(service)
        {
            UsersService = service;
        }
        [HttpGet("Login")]
        public Model.User? Login(string username, string password)
        {
            return UsersService.Login(username, password);
        }
    }
}
