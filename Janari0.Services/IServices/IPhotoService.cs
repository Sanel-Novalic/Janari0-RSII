using Janari0.Services.Requests;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Janari0.Model.SearchObjects;
namespace Janari0.Services.IServices
{
    public interface IPhotoService : ICRUDService<Model.Photo, BaseSearchObject, PhotoInsertRequest, PhotoUpdateRequest>
    {

    }
}
