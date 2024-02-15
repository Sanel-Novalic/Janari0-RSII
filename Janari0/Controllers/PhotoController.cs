using Janari0.Model.Requests;
using Janari0.Model.SearchObjects;
using Janari0.Services.IServices;

namespace Janari0.Controllers
{
    public class PhotoController : BaseCRUDController<Model.Photo, BaseSearchObject, PhotoInsertRequest, PhotoUpdateRequest>
    {
        public PhotoController(IPhotoService service)
            : base(service) { }
    }
}
