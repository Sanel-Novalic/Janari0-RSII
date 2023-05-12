using Janari0.Model.SearchObjects;
using Janari0.Services.Requests;

namespace Janari0.Services.IServices
{
    public interface IUsersService : ICRUDService<Model.User, UserSearchObject, UserInsertRequest, UserUpdateRequest>
    {
        Model.User Login(string username, string password);
    }
}
