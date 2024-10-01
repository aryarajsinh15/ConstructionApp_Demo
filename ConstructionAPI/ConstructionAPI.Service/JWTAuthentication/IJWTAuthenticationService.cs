using ConstructionAPI.Model.Token;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Service.JWTAuthentication
{
    public interface IJWTAuthenticationService
    {
        AccessTokenModel GenerateToken(TokenModel userToken, string JWT_Secret, int JWT_Validity_Mins);
        TokenModel GetTokenData(string jwtToken);
    }
}
