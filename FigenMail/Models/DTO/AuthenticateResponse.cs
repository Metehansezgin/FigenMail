using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace FigenMail.Models.DTO
{
    public class AuthenticateResponse
    {
         
        public int id { get; set; }
        public string Username { get; set; }
        public string NameSurname { get; set; }
        public string PgUsername { get; set; }
        public string Token { get; set; }


        public AuthenticateResponse(User user, string token)
        {
            id = user.id;
            Username = user.Username;
            NameSurname = user.NameSurname;
            PgUsername = user.PgUsername;
            Token = token;
        }

    }
}
