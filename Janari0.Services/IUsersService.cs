using Janari0.Services.Requests;

namespace Janari0.Services
{
    public interface IUsersService : ICRUDService<Model.User, UserInsertRequest, UserUpdateRequest>
    {
    }
}
