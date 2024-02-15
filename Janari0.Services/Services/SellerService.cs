using AutoMapper;
using Janari0.Model.Requests;
using Janari0.Model.SearchObjects;
using Janari0.Services.Context;
using Janari0.Services.IServices;

namespace Janari0.Services.Services
{
    public class SellerService : BaseCRUDService<Model.Seller, Database.Seller, SellerSearchObject, SellerInsertRequest, SellerUpdateRequest>, ISellersService
    {
        public SellerService(Janari0Context context, IMapper mapper)
            : base(context, mapper) { }
    }
}
