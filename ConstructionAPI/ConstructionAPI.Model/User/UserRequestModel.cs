﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Model.User
{
    public class UserRequestModel
    {
        public string? UserId { get; set; }
        public string UserName { get; set; }
        public string Password { get; set; }
        public string? clientId { get; set; }
        public string Name { get; set; }
        public string Email { get; set; }
        public string MobileNumber { get; set; }

    }
}
