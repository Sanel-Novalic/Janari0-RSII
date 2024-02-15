using Janari0.Model.Requests;
using Janari0.Model.SearchObjects;

namespace Janari0.Services.IServices
{
    public interface IOutputService : ICRUDService<Model.Output, OutputSearchObject, OutputUpsertRequest, OutputUpdateRequest> { }
}
