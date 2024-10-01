using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Model.PersonGroup
{
    public class PersonGroupListResponseModel
    {
        public Guid PersonGroupId { get; set; }
        public string GroupName { get; set; }
        public long? PersonCount { get; set; }
        public bool IsActive { get; set; }
        public long TotalRecords { get; set; }
    }
}
