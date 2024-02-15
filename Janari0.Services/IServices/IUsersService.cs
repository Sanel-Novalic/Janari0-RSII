using Janari0.Model.Requests;
using Janari0.Model.SearchObjects;

namespace Janari0.Services.IServices
{
    public interface IUsersService : ICRUDService<Model.User, UserSearchObject, UserInsertRequest, UserUpdateRequest>
    {
        Task<Model.User?> Login(string email, string password);
    }
}
