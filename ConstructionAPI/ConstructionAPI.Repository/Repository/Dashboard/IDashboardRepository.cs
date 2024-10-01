using ConstructionAPI.Model.Dashboard;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Repository.Repository.Dashboard
{
    public interface IDashboardRepository
    {
        Task<DashboardResponseModel> GetDashboardInfo(string? clientId);
    }
}
