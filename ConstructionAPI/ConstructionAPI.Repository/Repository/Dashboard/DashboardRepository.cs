using ConstructionAPI.Common.Helper;
using ConstructionAPI.Model.Config;
using ConstructionAPI.Model.Dashboard;
using Dapper;
using Microsoft.Extensions.Options;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Repository.Repository.Dashboard
{
    public class DashboardRepository : BaseRepository, IDashboardRepository
    {
        public DashboardRepository(IOptions<DataConfig> connectionString) : base(connectionString)
        {
        }

        public async Task<DashboardResponseModel> GetDashboardInfo(string? clientId)
        {
            var param = new DynamicParameters();
            param.Add("@clientId", clientId == "" ? null : clientId);
            var result = await QueryFirstOrDefaultAsync<DashboardResponseModel>(StoreProcedure.DashboardInfo,param, commandType: CommandType.StoredProcedure);
            return result;
        }
    }
}