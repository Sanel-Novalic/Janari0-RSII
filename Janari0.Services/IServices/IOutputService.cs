using Janari0.Model.Requests;
using Janari0.Model.SearchObjects;
using Janari0.Services.Requests;

namespace Janari0.Services.IServices
{
    public interface IOutputService : ICRUDService<Model.Output, OutputSearchObject, OutputUpsertRequest, OutputUpdateRequest>
    {
    }
}
