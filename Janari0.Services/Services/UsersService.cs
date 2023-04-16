using AutoMapper;
using Janari0.Model.SearchObjects;
using Janari0.Services.Context;
using Janari0.Services.Exceptions;
using Janari0.Services.IServices;
using Janari0.Services.Requests;
using System.Security.Cryptography.X509Certificates;

namespace Janari0.Services.Services
{
    public class UsersService : BaseCRUDService<Model.User, Database.User, UserSearchObject, UserInsertRequest, UserUpdateRequest>, IUsersService
    {
        public UsersService(Janari0Context context, IMapper mapper) : base(context, mapper) { }

        public override Model.User Insert(UserInsertRequest insert)
        {
            var user = Context.Users.Where(e => e.Username == insert.Username).FirstOrDefault();
            if (user != null)
            {
                throw new UserErrorException("Username already exists.");
            }
            user = Context.Users.Where(p => p.PhoneNumber == insert.PhoneNumber).FirstOrDefault();
            if (user != null)
            {
                throw new UserErrorException("Phone number already exists.");
            }
            // Make a better phone number validator
            var phoneNumberUtil = PhoneNumbers.PhoneNumberUtil.GetInstance();
            var number = phoneNumberUtil.Parse(insert.PhoneNumber, null);

            var location = Mapper.Map<Database.Location>(insert.Location);
            Context.Locations.Add(location);

            var dbentity = base.Insert(insert);
            Context.SaveChanges();

            return dbentity;
        }
        public override Model.User? Update(int id, UserUpdateRequest update)
        {
            var set = Context.Set<Database.User>();

            var entity = set.Find(id);

            if (entity == null) {
                throw new UserErrorException("User was not found.");
            }
            if(update.Username != null)
            {
                if(update.Username.Length < 3)
                {
                    throw new UserErrorException("Username must be longer than 2 characters!");
                }
                if(set.Where(x => x.Username == update.Username).Any())
                {
                    throw new UserErrorException("Username already exists!");
                }
            }
            Mapper.Map(update, entity);

            Context.SaveChanges();

            return Mapper.Map<Model.User>(entity);
        }
        public override IQueryable<Database.User> AddFilter(IQueryable<Database.User> query, UserSearchObject? search = null)
        {
            var filteredQuery = base.AddFilter(query, search);

            if (search?.Uid != null)
            {
                filteredQuery = filteredQuery.Where(x => x.Uid == search.Uid);
            }

            return filteredQuery;
        }
    }
}


