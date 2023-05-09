using AutoMapper;
using Janari0.Model.Requests;
using Janari0.Model.SearchObjects;
using Janari0.Services.Context;
using Janari0.Services.Database;
using Janari0.Services.Exceptions;
using Janari0.Services.IServices;
using Janari0.Services.Requests;
using Microsoft.EntityFrameworkCore;

namespace Janari0.Services.Services
{
    public class BuyersService : BaseCRUDService<Model.Buyer, Database.Buyer, BuyerSearchObject, BuyerInsertRequest, BuyerUpdateRequest>, IBuyersService
    {
        public BuyersService(Janari0Context context, IMapper mapper) : base(context, mapper)
        {
        }
        public override Model.Buyer Insert(BuyerInsertRequest insert)
        {
            insert.Status = true;
            var dbentity = base.Insert(insert);
            Context.SaveChanges();
            return dbentity;
        }
    }
}
