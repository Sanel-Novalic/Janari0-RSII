using AutoMapper;
using Janari0.Model.Requests;
using Janari0.Model.SearchObjects;
using Janari0.Services.Context;
using Janari0.Services.IServices;

namespace Janari0.Services.Services
{
    public class PhotoService : BaseCRUDService<Model.Photo, Database.Photo, BaseSearchObject, PhotoInsertRequest, PhotoUpdateRequest>, IPhotoService
    {
        public PhotoService(Janari0Context context, IMapper mapper)
            : base(context, mapper) { }
    }
}
