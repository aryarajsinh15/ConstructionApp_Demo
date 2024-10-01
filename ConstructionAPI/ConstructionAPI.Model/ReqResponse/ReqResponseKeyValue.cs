using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Model.ReqResponse
{
    public class ReqResponseKeyValue
    {
        public string? Key { get; set; }
        public string? Value { get; set; }
    }
    public class ParamValue
    {
        public string? HeaderValue { get; set; }
        public string? QueryStringValue { get; set; }
    }
    public class ResponseModel
    {
        public int IsSuccess { get; set; }
        public string Result { get; set; } 
    }
}
