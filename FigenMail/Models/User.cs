using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace FigenMail.Models
{
    public class User
    {
        [Key]
        public int id { get; set; }
        public string Username { get; set; }
        public string Password { get; set; }
        public string NameSurname { get; set; }
        public string PgUsername { get; set; }
        public string PgPassword { get; set; }           
    }
}
