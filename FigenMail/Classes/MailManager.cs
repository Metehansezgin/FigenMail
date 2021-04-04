using FigenMail.abstruct;
using FigenMail.Models;
using FigenMail.Models.DTO;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace FigenMail.Classes
{
    public class MailManager: IMailManager
    {

        public Boolean MailSent(Mail_Sent mail)
        {

            Add(mail);


            return true;
        }
        public Boolean Add(Mail_Sent mail)
        {
            using (Context db = new Context())
            {
                db.Database.ExecuteSqlRaw($"sp_MAIL_SENT_ADD '{mail.RecordTime}',{mail.refUser},'{mail.EmailReceiver}','{mail.EmailSubject}','{mail.EmailContent}',{mail.PgMailUniqueId}");
                return true;
            }
        }

        public List<Mail_Sent> GetListUserID(int id)
        {
            using (Context db = new Context())
            {
                return db.mail_sent.FromSqlRaw($"sp_MAIL_SENT_GET_LIST_WITH_USER {id}").ToList<Mail_Sent>();
            }
        }

        public Mail_Sent GetID(int id)
        {
            using (Context db = new Context())
            {
                return (Mail_Sent)db.mail_sent.FromSqlRaw($"sp_MAIL_SENT_GET_WITH_ID {id}");
            }
        }

 
        public Mail_Template GetMailTemplateID(int id)
        {
            using (Context db = new Context())
            {
                List<Mail_Template> list = db.mail_template.FromSqlRaw($"sp_MAIL_TEMPLATE_GET_WITH_ID {id}").ToList<Mail_Template>();
                if (list == null) return null;
                if (list.Count == 0) return null;

                return list[0];
            }
        }


        public List<Mail_Template> GetMailTemplateList()
        {
            using (Context db = new Context())
            {
                return db.mail_template.FromSqlRaw("sp_MAIL_TEMPLATE_GET_LIST").ToList<Mail_Template>();
            }
        }
    }
}
