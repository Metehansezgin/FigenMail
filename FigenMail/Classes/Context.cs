using FigenMail.Models;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace FigenMail.Classes
{
    public class Context: DbContext
    {
        
        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            optionsBuilder.UseSqlServer("Data Source=METEHANPC\\SQLEXPRESS;Initial Catalog=FigenSoftDB;Integrated Security=True");
        }
        public DbSet<User> user { get; set; }
        public DbSet<Mail_Sent> mail_sent { get; set; }
        public DbSet<Mail_Template> mail_template { get; set; }
    }
}
