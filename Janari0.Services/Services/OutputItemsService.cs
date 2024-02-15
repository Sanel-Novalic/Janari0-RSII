using AutoMapper;
using Janari0.Model.Requests;
using Janari0.Model.SearchObjects;
using Janari0.Services.Context;
using Janari0.Services.IServices;

namespace Janari0.Services.Services
{
    public class OutputItemsService
        : BaseCRUDService<Model.OutputItem, Database.OutputItem, OutputItemSearchObject, OutputItemUpsertRequest, OutputItemUpsertRequest>,
            IOutputItemsService
    {
        public OutputItemsService(Janari0Context context, IMapper mapper)
            : base(context, mapper) { }
    }
}
