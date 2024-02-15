using AutoMapper;
using Janari0.Model.Requests;
using Janari0.Model.SearchObjects;
using Janari0.Services.Context;
using Janari0.Services.IServices;

namespace Janari0.Services.Services
{
    public class LocationService : BaseCRUDService<Model.Location, Database.Location, BaseSearchObject, LocationInsertRequest, LocationUpdateRequest>, ILocationService
    {
        public LocationService(Janari0Context context, IMapper mapper)
            : base(context, mapper) { }
    }
}
