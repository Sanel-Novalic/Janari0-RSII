using Janari0.Model.SearchObjects;
using Janari0.Services.IServices;
using Janari0.Services.Requests;
using Microsoft.AspNetCore.Mvc;

namespace Janari0.Controllers
{
    public class UsersController : BaseCRUDController<Model.User, UserSearchObject, UserInsertRequest, UserUpdateRequest>
    {
        public UsersController(IUsersService service): base(service)
        {
        }
    }
}
