using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace FigenMail.Models
{
    public class Mail_Template
    {
        [Key]
        public int id { get; set; }
        public string TemplateName { get; set; }
        public string EmailContent { get; set; }
 
    }
}
