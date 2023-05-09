using Janari0.Model.SearchObjects;
using Janari0.Services.Requests;

namespace Janari0.Services.IServices
{
    public interface IOutputItemsService : ICRUDService<Model.OutputItem, OutputItemSearchObject, OutputItemUpsertRequest, OutputItemUpsertRequest>
    {
    }
}
