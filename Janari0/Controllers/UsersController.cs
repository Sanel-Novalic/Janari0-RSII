using Janari0.Model.Requests;
using Janari0.Model.SearchObjects;
using Janari0.Services.IServices;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace Janari0.Controllers
{
    public class UsersController : BaseCRUDController<Model.User, UserSearchObject, UserInsertRequest, UserUpdateRequest>
    {
        public IUsersService UsersService { get; set; }

        public UsersController(IUsersService service)
            : base(service)
        {
            UsersService = service;
        }

        [AllowAnonymous]
        [HttpGet("Login")]
        public async Task<Model.User?> Login(string email, string password)
        {
            return await UsersService.Login(email, password);
        }
    }
}
