using ConstructionAPI.Model.Dashboard;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Service.Dashboard
{
    public interface IDashboardService
    {
        Task<DashboardResponseModel> GetDashboardInfo( string? clientId);
    }
}