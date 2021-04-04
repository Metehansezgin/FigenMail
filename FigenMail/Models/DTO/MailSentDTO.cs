using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace FigenMail.Models.DTO
{
    public class MailSentDTO
    {   
        public string EmailReceiver { get; set; }
        public string EmailSubject { get; set; }
        public string EmailContent { get; set; }
    }
}
