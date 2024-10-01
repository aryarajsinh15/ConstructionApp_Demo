using ConstructionAPI.Common.Helper;
using ConstructionAPI.Model.Common;
using ConstructionAPI.Model.Config;
using ConstructionAPI.Model.Marchant;
using ConstructionAPI.Model.PersonGroup;
using ConstructionAPI.Model.ReqResponse;
using Dapper;
using Microsoft.Extensions.Options;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Repository.Repository.PersonGroup
{
    public class PersongroupRepository : BaseRepository, IPersonGroupRepository
    {
        #region Fields              
        #endregion

        #region Constructor
        public PersongroupRepository(IOptions<DataConfig> dataConfig) : base(dataConfig)
        {
        }
        #endregion

        #region Methods
        public async Task<List<PersonGroupListResponseModel>> GetGroupList(CommonPaginationModel model, string clientId)
        {
            var param = new DynamicParameters();
            param.Add("@pageIndex", model.PageNumber);
            param.Add("@pageSize", model.PageSize);
            param.Add("@orderBy", model.SortColumn);
            param.Add("@sortOrder", model.SortOrder);
            param.Add("@strSearch", model.StrSearch);
            param.Add("@clientId", clientId);
            var data = await QueryAsync<PersonGroupListResponseModel>(StoreProcedure.GetPersonGroupList, param, commandType: CommandType.StoredProcedure);
            return data.ToList();
        }

        public async Task<ResponseModel> SavePersonGroup(PersonGroupRequestModel model, System.Guid id, System.Guid ClientId)
        {
            DataTable dtPersonGroup = new DataTable("tbl_PersonGroupMapping");
            dtPersonGroup.Columns.Add("PersonGroupMapId", typeof(string));
            dtPersonGroup.Columns.Add("PersonId", typeof (string));
            dtPersonGroup.Columns.Add("PersonGroupId", typeof (string));
            for (int i = 0; i < model.groupMap.Count; i++)
            {
                DataRow dtRow = dtPersonGroup.NewRow();
                dtRow["PersonGroupMapId"] = model.groupMap[i].PersonGroupMapId;
                dtRow["PersonId"] = model.groupMap[i].PersonId;
                dtRow["PersonGroupId"] = model.groupMap[i].PersonGroupId;   
                dtPersonGroup.Rows.Add(dtRow);
            }
            try
            {
                var param = new DynamicParameters();
                param.Add("@PersonGroupId", model.PersonGroupId);
                param.Add("@ClientId", id);
                param.Add("@GroupName", model.GroupName);
                param.Add("@CreatedBy", ClientId);
                param.Add("@PersonGroupMap", dtPersonGroup.AsTableValuedParameter("[dbo].[tbl_PersonGroupMapping]") );
                var data = await QueryFirstOrDefaultAsync<ResponseModel>(StoreProcedure.SavePersonGroup, param, commandType: CommandType.StoredProcedure);
                return data;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public async Task<int> DeletePersonGroup(System.Guid groupId, System.Guid clientId)
        {
            var param = new DynamicParameters();
            param.Add("@PersonGroupId", groupId);
            param.Add("@ClientId", clientId);
            return await QueryFirstOrDefaultAsync<int>(StoreProcedure.DeletePersonGroup, param, commandType: CommandType.StoredProcedure);
        }

        public async Task<ResponseModel> ActiveInactivePersonGroup(string id, Guid userId)
        {
            var param = new DynamicParameters();
            param.Add("@PersonGroupId", id);
            param.Add("@UserId", userId);
            return await QueryFirstOrDefaultAsync<ResponseModel>(StoreProcedure.ActiveInActivePersonGroup, param, commandType: CommandType.StoredProcedure);
        }
        #endregion
    }
}
