using FigenMail.Models;
using FigenMail.Models.DTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace FigenMail.abstruct
{
    public interface IUserManager
    {
        Boolean Register(User user);
        Boolean Edit(User user);
        Boolean Delete(int id);
        User GetUserID(int id);
        User GetUser(string username);
        AuthenticateResponse Authenticate(AuthenticateRequest username);
    }
}
