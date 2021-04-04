using System;
using System.Collections.Generic;
 
using System.Linq;
using System.Security.Claims;
using System.Text;
using System.Threading.Tasks;
using FigenMail.abstruct;
using FigenMail.Helpers;
using FigenMail.Models;
using FigenMail.Models.DTO;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
 

namespace FigenMail.Controllers
{
    [Route("api/[controller]")]
    [Authorize]
    [ApiController]
    public class MailController : ControllerBase
    {

        IMailManager _mailmanager;
        public MailController(IMailManager mailmanager)
        {
            _mailmanager = mailmanager;
        }

        [HttpGet("getList")]
        public IActionResult GetList()
        {
            var response = _mailmanager.GetMailTemplateList();

            if (response == null)
                return BadRequest(new { message = "No Template" });

            return Ok(response);
        }

        [HttpGet("get/{id}")]
        public IActionResult GetID(int id)
        {
            var response = _mailmanager.GetMailTemplateID(id);

            if (response == null)
                return BadRequest(new { message = "No Template" });

            return Ok(response);
        }

        
        [HttpGet("mailsent")]
        public IActionResult MailSent(MailSentDTO mail)
        {
            var identity = HttpContext.User.Identity as ClaimsIdentity;
            IList<Claim> claims = identity.Claims.ToList<Claim>();
            var id = claims[0].Value;

            Mail_Sent _mail = new Mail_Sent();
            _mail.EmailContent = mail.EmailContent;
            _mail.EmailReceiver = mail.EmailReceiver;
            _mail.EmailSubject = mail.EmailSubject;
            _mail.refUser = int.Parse(id);
        
           _mail.RecordTime = DateTime.Now;
           
             
            
            _mail.PgMailUniqueId = 1;
            if (_mailmanager.MailSent(_mail)) {
                return Ok();
            }
            else
            {
                return Ok(new { message = "Error" });
            }
            
        }

    }
}