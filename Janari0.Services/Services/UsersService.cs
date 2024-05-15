using AutoMapper;
using Janari0.Model.Requests;
using Janari0.Model.SearchObjects;
using Janari0.Services.Context;
using Janari0.Services.HelperMethods;
using Janari0.Services.IServices;
using Microsoft.EntityFrameworkCore;
using System.Net.Mail;

namespace Janari0.Services.Services
{
    public class UsersService : BaseCRUDService<Model.User, Database.User, UserSearchObject, UserInsertRequest, UserUpdateRequest>, IUsersService
    {
        public UsersService(Janari0Context context, IMapper mapper)
            : base(context, mapper) { }

        public override async Task<Model.User?> Insert(UserInsertRequest insert)
        {
            var user = Context.Users.Where(e => e.Username == insert.Username).FirstOrDefault();
            string message = "Something went wrong";
            if (user != null)
            {
                message = $"User with the same username already exists.";
                throw new ArgumentException(message);
            }
            user = Context.Users.Where(p => p.PhoneNumber == insert.PhoneNumber).FirstOrDefault();
            if (user != null)
            {
                message = $"User with the same phone number already exists.";
                throw new ArgumentException(message);
            }
            user = Context.Users.Where(p => p.Email == insert.Email).FirstOrDefault();
            if (user != null)
            {
                message = $"User with the same email already exists.";
                throw new ArgumentException(message);
            }

            if (insert.Username == null || insert.Username.Length < 3)
            {
                message = $"Username must be bigger than 3 characters";
                throw new ArgumentException(message);
            } else if (!IsValid(insert.Email))
            {
                message = $"Email is invalid";
                throw new ArgumentException(message);
            }

            var location = Mapper.Map<Database.Location>(insert.Location);
            Context.Locations.Add(location);

            var dbentity = await base.Insert(insert);
            await Context.SaveChangesAsync();

            return dbentity;
        }

        public override async Task<Model.User?> Update(int id, UserUpdateRequest update)
        {
            var set = Context.Set<Database.User>();

            var entity = await set.FindAsync(id);

            if (entity == null)
            {
                return null;
            }

            if (update.Username != null)
            {
                if (update.Username.Length < 3)
                {
                    return null;
                }
                if (set.Where(x => x.Username == update.Username && x.UserId != id).Any())
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
            await Context.SaveChangesAsync();

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

        public async Task<Model.User?> Login(string email, string password)
        {
            var entity = await Context.Users.FirstOrDefaultAsync(x => x.Email == email);

            if (entity == null)
                return null;

            var hash = HashingAndSaltingMethod.GenerateHash(entity.PasswordSalt!, password);

            if (hash != entity.PasswordHash)
                return null;

            return Mapper.Map<Model.User?>(entity);
        }

        public bool IsValid(string emailaddress)
        {
            try
            {
                MailAddress m = new MailAddress(emailaddress);

                return true;
            }
            catch (FormatException)
            {
                return false;
            }
        }
    }
}
