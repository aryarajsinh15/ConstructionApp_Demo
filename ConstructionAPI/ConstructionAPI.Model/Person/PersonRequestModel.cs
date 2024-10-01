using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Model.Person
{
    public class PersonRequestModel
    {
        public string? PersonId {get; set;}
        public string PersonFirstName { get; set; }
        public string? PersonAddress { get; set; }
        public string? MobileNo { get; set; }        
    }
    public class AttendantPersonRequestModel
    {
        public string? PersonId { get; set; }
        public string PersonFirstName { get; set; }
        public string? PersonAddress { get; set; }
        public string? MobileNo { get; set; }
        public long PersonTypeId { get; set; }
        public long DailyRate { get; set; }
    }
}
