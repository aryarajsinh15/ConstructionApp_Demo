﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Model.Token
{
    public class AccessTokenModel
    {
        public string Token { get; set; }
        public int ValidityInMin { get; set; }
        public DateTime ExpiresOnUTC { get; set; }
        public System.Guid Id { get; set; }
    }
}
