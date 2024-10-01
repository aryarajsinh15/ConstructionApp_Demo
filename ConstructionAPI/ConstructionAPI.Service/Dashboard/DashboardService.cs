using ConstructionAPI.Model.Dashboard;
using ConstructionAPI.Repository.Repository.Client;
using ConstructionAPI.Repository.Repository.Dashboard;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Service.Dashboard
{
    public class DashboardService : IDashboardService
    {
        #region Fields
        private readonly IDashboardRepository _repository;
        #endregion

        #region Construtor
        public DashboardService(IDashboardRepository repository)
        {
            _repository = repository;
        }

        #endregion

        #region Methods

        public async Task<DashboardResponseModel> GetDashboardInfo(string? clientId)
        {
            return await _repository.GetDashboardInfo(clientId);
        }

        #endregion
    }
}
