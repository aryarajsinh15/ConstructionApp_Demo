using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Model.PersonGroup
{
    public class PersonGroupRequestModel
    {
        public string? PersonGroupId { get; set; }
        public string? GroupName { get; set; }
        public string? ClientId { get; set; }

        public List<PersonGroupMapModel> groupMap { get; set; }
    }

    public class PersonGroupMapModel
    {
        public string? PersonGroupMapId { get; set; }
        public string? PersonId { get; set; }
        public string? PersonGroupId { get; set; }
    }
}
