using System;
using System.Collections.Generic;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Security.Claims;
using System.Text;
using System.Threading.Tasks;
using FigenMail.abstruct;
using FigenMail.Classes;
using FigenMail.Models;
using FigenMail.Models.DTO;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.IdentityModel.Tokens;

namespace FigenMail.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UserController : ControllerBase
    {
         
        private IUserManager _user;
        public UserController(IUserManager user)
        {
            _user = user;
        }

        [HttpPost("register")]
        public String Register(RegisterDTO user)
        { 
             
            if(_user.Register(new User { 
                Username=user.Username,
                Password=user.Password,
                NameSurname=user.NameSurname,
                PgPassword=user.PgPassword,
                PgUsername=user.PgUsername
            }))
            {
                return "OK";
            }
            else
            {
                return "Error";
            }
            
        }


        [HttpPost("login")]
        public IActionResult Login(AuthenticateRequest model)
        {
            var response = _user.Authenticate(model);

            if (response == null)
                return BadRequest(new { message = "Username or password is incorrect" });

            return Ok(response);
        }

        [HttpGet("UserProfile")]
        public IActionResult UserProfile()
        {
            var identity = HttpContext.User.Identity as ClaimsIdentity;
            IList<Claim> claims = identity.Claims.ToList<Claim>();
            var id = claims[0].Value;
            User user= _user.GetUserID(int.Parse(id));
            user.Password = null;
            user.PgPassword = null;
            return Ok(user);

        }



    }
}