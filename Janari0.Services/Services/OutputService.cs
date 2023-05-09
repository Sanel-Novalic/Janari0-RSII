using AutoMapper;
using Janari0.Model.SearchObjects;
using Janari0.Services.Context;
using Janari0.Services.Database;
using Janari0.Services.IServices;
using Janari0.Services.Requests;
using Microsoft.EntityFrameworkCore;

namespace Janari0.Services.Services
{
    public class OutputService : BaseCRUDService<Model.Output, Database.Output, OutputSearchObject, OutputUpsertRequest, OutputUpsertRequest>, IOutputService
    {
        public OutputService(Janari0Context context, IMapper mapper) : base(context, mapper)
        {
        }
    }
}
