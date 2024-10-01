using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Common.Enum
{
    public static class Status
    {
        public const int AlreadyExists = -1;
        public const int Failed = 0;
        public const int Success = 1;
        public const int Saved = 2;
        public const int Updated = 3;
        public const int Deleted = 4;
        public const int Activited = 5;
        public const int InActivated = 6;
        public const int BeingUsed = 7;
    }
    public static class ActiveStatus
    {
        public const int Active = 1;
        public const int Inactive = 0;
    }
    public static class LoginStatus
    {
        public const int UserDeactive = 2;
        public const int CompanyInActivated = 3;
        public const int CompanyPackageExpired = 4;
        public const int EmailNotExist = 404;
    }

}
