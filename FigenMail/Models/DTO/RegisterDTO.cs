using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace FigenMail.Models.DTO
{
    public class RegisterDTO
    {
        public string Username { get; set; }
        public string Password { get; set; }
        public string NameSurname { get; set; }
        public string PgUsername { get; set; }
        public string PgPassword { get; set; }
    }
}
