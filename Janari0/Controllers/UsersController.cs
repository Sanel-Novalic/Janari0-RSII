using Janari0.Services;
using Janari0.Services.Requests;
using Microsoft.AspNetCore.Mvc;

namespace Janari0.Controllers
{
    public class UsersController : BaseCRUDController<Model.User, UserInsertRequest, UserUpdateRequest>
    {
        public UsersController(IUsersService service): base(service)
        {
        }
    }
}
