using Janari0.Model;
using Janari0.Model.SearchObjects;
using Janari0.Services.IServices;
using Janari0.Services.Requests;

namespace Janari0.Controllers
{
    public class PhotoController : BaseCRUDController<Model.Photo, BaseSearchObject, PhotoInsertRequest, PhotoUpdateRequest>
    {
        public PhotoController(IPhotoService service) : base(service)
        {
        }
    }
}
