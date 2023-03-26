using AutoMapper;
using Janari0.Model;
using Janari0.Services.Database;
using Janari0.Services.Exceptions;
using Janari0.Services.Requests;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Janari0.Services
{
    public class UsersService : BaseCRUDService<Model.User, Database.User, Requests.UserInsertRequest, Requests.UserUpdateRequest>, IUsersService
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
            var dbentity = base.Insert(insert);
            Context.SaveChanges();

            return dbentity;
        }
    }
}


