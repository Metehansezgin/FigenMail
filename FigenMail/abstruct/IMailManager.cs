using FigenMail.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace FigenMail.abstruct
{
   public interface IMailManager
    {
        Mail_Template GetMailTemplateID(int id);
        List<Mail_Template> GetMailTemplateList();
        Boolean MailSent(Mail_Sent mail);
    }
}
