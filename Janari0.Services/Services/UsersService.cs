using AutoMapper;
using Janari0.Model.SearchObjects;
using Janari0.Services.Context;
using Janari0.Services.Exceptions;
using Janari0.Services.HelperMethods;
using Janari0.Services.IServices;
using Janari0.Services.Requests;
using Microsoft.AspNetCore.Http;
using Microsoft.EntityFrameworkCore;
using Microsoft.ML;
using System.Collections.Generic;
using System.Security.Cryptography.X509Certificates;

namespace Janari0.Services.Services
{
    public class UsersService : BaseCRUDService<Model.User, Database.User, UserSearchObject, UserInsertRequest, UserUpdateRequest>, IUsersService
    {
        public UsersService(Janari0Context context, IMapper mapper) : base(context, mapper) { }

        public override Model.User? Insert(UserInsertRequest insert)
        {
            var user = Context.Users.Where(e => e.Username == insert.Username).FirstOrDefault();
            if (user != null)
            {
                return null;
            }
            user = Context.Users.Where(p => p.PhoneNumber == insert.PhoneNumber).FirstOrDefault();
            if (user != null)
            {
                return null;
            }
            user = Context.Users.Where(p => p.Email == insert.Email).FirstOrDefault();
            if(user != null)
            {
                return null;
            }
            // Make a better phone number validator

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

            if (entity == null)
            {
                return null;
            }

            if (update.Username != null)
            {
                if(update.Username.Length < 3)
                {
                    return null;
                }
                if(set.Where(x => x.Username == update.Username && x.UserId != id).Any())
                {
                    return null;
                }
            }
            var user = Context.Users.Where(p => p.PhoneNumber == update.PhoneNumber && p.UserId != id).FirstOrDefault();
            if (user != null)
            {
                return null;
            }
            
            entity.Username = update.Username == null ? entity.Username : update.Username;
            entity.PhoneNumber = update.PhoneNumber == null ? entity.PhoneNumber : update.PhoneNumber;
            entity.Email = update.Email == null ? entity.Email : update.Email;
            entity.Uid = update.Uid == null ? entity.Uid : update.Uid;

            Context.Entry(entity).State = EntityState.Modified;
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
        public Model.User? Login(string username, string password)
        {
            var entity = Context.Users.FirstOrDefault(x => x.Username == username);

            if (entity == null || entity.Role != "admin")
                return null;

            var hash = HashingAndSaltingMethod.GenerateHash(entity.PasswordSalt, password);

            if (hash != entity.PasswordHash)
                return null;

            return Mapper.Map<Model.User?>(entity);
        }
    }
}


