﻿using ConstructionAPI.Model.Token;
using Microsoft.IdentityModel.Tokens;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Security.Claims;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Service.JWTAuthentication
{
    public class JWTAuthenticationService : IJWTAuthenticationService
    {
        public AccessTokenModel GenerateToken(TokenModel userToken, string JWT_Secret, int JWT_Validity_Mins)
        {
            string serializeToken = JsonConvert.SerializeObject(userToken, Newtonsoft.Json.Formatting.None, new JsonSerializerSettings() { ReferenceLoopHandling = ReferenceLoopHandling.Ignore });

            var tokenDescriptor = new SecurityTokenDescriptor
            {
                Subject = new ClaimsIdentity(new Claim[]
                {
                    new Claim(ClaimTypes.Name, serializeToken)
                }),
                Expires = DateTime.UtcNow.AddMinutes(JWT_Validity_Mins),
                SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(Encoding.ASCII.GetBytes(JWT_Secret)), SecurityAlgorithms.HmacSha512Signature)
            };

            var tokenHandler = new JwtSecurityTokenHandler();
            var token = tokenHandler.CreateToken(tokenDescriptor);
            var tokenString = tokenHandler.WriteToken(token);
            AccessTokenModel accessTokenVM = new AccessTokenModel();
            accessTokenVM.Token = tokenString;
            accessTokenVM.ValidityInMin = JWT_Validity_Mins;
            accessTokenVM.ExpiresOnUTC = tokenDescriptor.Expires.Value;
            accessTokenVM.Id = userToken.UserId;
            return accessTokenVM;
        }

        public TokenModel GetTokenData(string jwtToken)
        {
            TokenModel TokenData = null;
            JwtSecurityTokenHandler tokenHandler = new JwtSecurityTokenHandler();
            JwtSecurityToken securityToken = (JwtSecurityToken)tokenHandler.ReadToken(jwtToken);
            IEnumerable<Claim> claims = securityToken.Claims;
            if (claims != null && claims.ToList().Count > 0)
            {
                var claimData = claims.ToList().FirstOrDefault().Value;
                TokenData = JsonConvert.DeserializeObject<TokenModel>(claimData);
                TokenData.TokenValidTo = securityToken.ValidTo;
            }
            return TokenData;
        }
    }
}
