using Janari0.Model.Requests;
using Janari0.Model.SearchObjects;
using Janari0.Services.IServices;

namespace Janari0.Controllers
{
    public class LocationController : BaseCRUDController<Model.Location, BaseSearchObject, LocationInsertRequest, LocationUpdateRequest>
    {
        public LocationController(ILocationService service)
            : base(service) { }
    }
}
