using Janari0.Model.Requests;
using Janari0.Model.SearchObjects;
using Janari0.Services.IServices;
using Janari0.Services.Requests;

namespace Janari0.Controllers
{

    public class OutputController : BaseCRUDController<Model.Output, OutputSearchObject, OutputUpsertRequest, OutputUpdateRequest>
    {
        public OutputController(IOutputService outputService) : base(outputService) {}

    }
}

