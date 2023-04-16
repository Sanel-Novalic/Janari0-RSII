using AutoMapper;
using Janari0.Model.SearchObjects;
using Janari0.Services.Context;
using Janari0.Services.IServices;
using Janari0.Services.Requests;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Janari0.Services.Services
{
    public class PhotoService : BaseCRUDService<Model.Photo, Database.Photo, BaseSearchObject, PhotoInsertRequest, PhotoUpdateRequest>, IPhotoService
    {
        public PhotoService(Janari0Context context, IMapper mapper) : base(context, mapper)
        {
        }
    }
}
