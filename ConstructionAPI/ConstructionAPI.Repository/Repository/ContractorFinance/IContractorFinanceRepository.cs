﻿using ConstructionAPI.Model.Client;
using ConstructionAPI.Model.Common;
using ConstructionAPI.Model.ContractorFinance;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Repository.Repository.NewFolder
{
    public interface IContractorFinanceRepository
    {
        Task<List<ContractorFinanceListResponseModel>> GetContractorFinanceList(ContractorFinanceListRequestModel model);
        Task<List<ContractorFinanceListResponseModel>> GetContractorFinanceListForExport(string siteId);

        Task<long> DeleteContractorFinance(System.Guid contractorFinanceId, System.Guid userId);
        Task<ContractorFinanceResponseModel> GetContractorFinanceById(System.Guid contractorFinanceId);
        Task<long> SaveContractorFinance(ContractorFinanceRequestModel model, System.Guid userId);
    }
}