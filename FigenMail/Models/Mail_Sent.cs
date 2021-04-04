using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace FigenMail.Models
{
    public class Mail_Sent
    {
        [Key]
        public int id { get; set; }
        public DateTime RecordTime { get; set; }
        public int refUser { get; set; }
        public string EmailReceiver { get; set; }
        public string EmailSubject { get; set; }
        public string EmailContent { get; set; }
        public int PgMailUniqueId { get; set; }
    }
}
