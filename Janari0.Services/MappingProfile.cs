using AutoMapper;
using Janari0.Services.Requests;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Janari0.Services
{
    public class MappingProfile : Profile
    {
        public MappingProfile() {
            CreateMap<Database.User, Model.User>();
            CreateMap<Database.Product, Model.Product>();
            CreateMap<Database.ProductsSale, Model.ProductsSale>();
            CreateMap<Database.Photo, Model.Photo>();
            CreateMap<Database.Location, Model.Location>();
            CreateMap<ProductInsertRequest, Database.Product>();
            CreateMap<ProductUpdateRequest, Database.Product>();
            CreateMap<UserInsertRequest, Database.User>();
            CreateMap<UserUpdateRequest, Database.User>();
        }
        
    }
}
