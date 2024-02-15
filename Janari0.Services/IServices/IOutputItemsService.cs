using Janari0.Model.Requests;
using Janari0.Model.SearchObjects;

namespace Janari0.Services.IServices
{
    public interface IOutputItemsService : ICRUDService<Model.OutputItem, OutputItemSearchObject, OutputItemUpsertRequest, OutputItemUpsertRequest> { }
}
