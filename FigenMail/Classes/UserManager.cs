using FigenMail.abstruct;
using FigenMail.Helpers;
using FigenMail.Models;
using FigenMail.Models.DTO;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Options;
using Microsoft.IdentityModel.Tokens;
using System;
using System.Collections.Generic;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Security.Claims;
using System.Text;
using System.Threading.Tasks;

namespace FigenMail.Classes
{
    public class UserManager: IUserManager
    {
        private  AppSettings _appSettings;

        public UserManager(IOptions<AppSettings> appSettings)
        {
            _appSettings = appSettings.Value;
        }
    
        public Boolean Register(User user)
        {
            using (Context db=new Context())
            {
              db.Database.ExecuteSqlRaw($"sp_UserAdd {user.Username},{user.Password},{user.NameSurname},{user.PgUsername},{user.PgPassword}");
              return true;
            }
        }

        public Boolean Edit(User user)
        {
            using (Context db = new Context())
            {
                db.Database.ExecuteSqlRaw($"sp_UserEdit {user.id},{user.Username},{user.Password},{user.NameSurname},{user.PgUsername},{user.PgPassword}");
                return true;
            }
        }
        public Boolean Delete (int id)
        {
            using (Context db = new Context())
            {
                db.Database.ExecuteSqlRaw($"sp_UserDelete {id}");
                return true;
            }
        }


        public User GetUserID(int id)
        {
            using (Context db = new Context())
            {         
                 
                return  db.user.FromSqlRaw($"sp_UserGetWithID {id}").ToList<User>()[0];
            }
        }

        public User GetUser(string username)
        {
            using (Context db = new Context())
            {
                List<User> user = db.user.FromSqlRaw($"sp_UserGetWithUserName {username}").ToList<User>();

                if (user.Count == 0) return null;
                if (user == null) return null;

                return user[0];                 
            }
        }

        public AuthenticateResponse Authenticate(AuthenticateRequest model)
        {
            using (Context db = new Context())
            {

                User user = GetUser(model.Username); ;

                if (user == null) return null;
                if (user.Password != model.Password) return null;

                var token = generateJwtToken(user);

                return new AuthenticateResponse(user, token);


            }
        }

        private string generateJwtToken(User user)
        {
            var tokenHandler = new JwtSecurityTokenHandler();
            var key = Encoding.ASCII.GetBytes(_appSettings.Secret);
            var tokenDescriptor = new SecurityTokenDescriptor
            {
                Subject = new ClaimsIdentity(new[] { new Claim("id", user.id.ToString()) }),
                Expires = DateTime.UtcNow.AddDays(7),
                SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(key), SecurityAlgorithms.HmacSha256Signature)
            };
            var token = tokenHandler.CreateToken(tokenDescriptor);
          
            return tokenHandler.WriteToken(token);
        }
    }
}
