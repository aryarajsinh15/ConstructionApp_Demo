using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Model.User
{
    public class UserResponseModel
    {
        public System.Guid UserId { get; set; }
        public string UserName { get; set; }
        public string UserPhoto { get; set; }
        public string password { get; set; }
        public string Name { get; set; }
        public string EmailId { get; set; }
        public string MobileNo { get; set; }
        public bool IsActive { get; set; }
    }
    public class UserListResponseModel
    {
        public System.Guid UserId { get; set; }
        public string UserName { get; set; }
        public string UserPhoto { get; set; }
        public string password { get; set; }
        public string Name { get; set; }
        public string EmailId { get; set; }
        public string MobileNo { get; set; }
        public bool IsActive { get; set; }
        public string ClientName { get; set; }
        public System.Guid ClientId { get; set; }
        public string TotalRecords { get; set; }
    }

    public class ActiveUserResponseModel
    {
        public System.Guid UserId { get; set; }
        public string? Name { get; set; }
        public string? EmailId { get; set; }
        public bool IsActive { get; set; }

    }
}
