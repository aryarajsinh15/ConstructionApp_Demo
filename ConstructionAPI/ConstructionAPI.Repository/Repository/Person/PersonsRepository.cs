using ConstructionAPI.Common.Helper;
using ConstructionAPI.Model.Common;
using ConstructionAPI.Model.Config;
using ConstructionAPI.Model.Marchant;
using ConstructionAPI.Model.Person;
using ConstructionAPI.Model.ReqResponse;
using Dapper;
using Microsoft.Extensions.Options;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Repository.Repository.Person
{
    public class PersonsRepository: BaseRepository, IPersonRepository
    {
        #region Constructor
        public PersonsRepository(IOptions<DataConfig> dataConfig) : base(dataConfig)
        {
        }
        #endregion

        #region Add, Update, Delete, List Methods 
        public async Task<List<PersonResponseModel>> GetPersonList(PersonRequestFilterModel model, string clientId)
        {
            var param = new DynamicParameters();
            param.Add("@pageIndex", model.PageNumber);
            param.Add("@pageSize", model.PageSize);
            param.Add("@orderBy", model.SortColumn);
            param.Add("@sortOrder", model.SortOrder);
            param.Add("@strSearch", model.StrSearch);
            param.Add("@clientId", clientId);
            param.Add("@startDate", model.StartDate);
            param.Add("@endDate", model.EndDate);
            param.Add("@activeInActiveStatus", model.ActiveInActiveStatus);
            var data = await QueryAsync<PersonResponseModel>(StoreProcedure.GetPersontList, param, commandType: CommandType.StoredProcedure);
            return data.ToList();
        }
        public async Task<List<PersonResponseModel>> GetAttendancePersonList(PersonAttedanceRequestFilterModel model, string clientId)
        {
            var param = new DynamicParameters();
            param.Add("@pageIndex", model.PageNumber);
            param.Add("@pageSize", model.PageSize);
            param.Add("@orderBy", model.SortColumn);
            param.Add("@sortOrder", model.SortOrder);
            param.Add("@strSearch", model.StrSearch);
            param.Add("@clientId", clientId);
            param.Add("@activeInActiveStatus", model.ActiveInActiveStatus);
            var data = await QueryAsync<PersonResponseModel>(StoreProcedure.GetAttendancePersontList, param, commandType: CommandType.StoredProcedure);
            return data.ToList();
        }

        public async Task<List<PersonDropDownModel>> GetPersonListForDropDown(string clientId, string id)
        {
            var param = new DynamicParameters();
            param.Add("@ClientId", clientId);
            if (id != "null") {
                param.Add("@PersonGroupId", id);
            }
            else
            {
                param.Add("@PersonGroupId","");
            }
        
            var data = await QueryAsync<PersonDropDownModel>(StoreProcedure.GetPersontListForDropDown, param, commandType: CommandType.StoredProcedure);
            return data.ToList();
        }

        public async Task<PersonResponseModel> GetPersonById(Guid id)
        {
            var param = new DynamicParameters();
            param.Add("@Id", id);
            return await QueryFirstOrDefaultAsync<PersonResponseModel>(StoreProcedure.GetPersonById, param, commandType: CommandType.StoredProcedure);
            
        }
        public async Task<ResponseModel> SavePerson(PersonRequestModel model, string id, string userId)
        {
            var param = new DynamicParameters();
            param.Add("@PersonId", model.PersonId);
            param.Add("@PersonFirstName", model.PersonFirstName);
            param.Add("@PersonAddress", model.PersonAddress);
            param.Add("@MobileNo", model.MobileNo);
            param.Add("@ClientId", id);
            param.Add("@CreatedBy", userId);
            var data = await QueryFirstOrDefaultAsync<ResponseModel>(StoreProcedure.SavePerson, param, commandType: CommandType.StoredProcedure);
            return data;
        }

        public async Task<long> DeletePersons(System.Guid id, System.Guid userId)
        {
            var param = new DynamicParameters();
            param.Add("@Id", id);
            param.Add("@userId", userId);
            return await QueryFirstOrDefaultAsync<long>(StoreProcedure.DeletePerson, param, commandType: CommandType.StoredProcedure);
        }

        public async Task<List<PersonTypeResponseModel>> GetPersonTypeList()
        {
            var data = await QueryAsync<PersonTypeResponseModel>(StoreProcedure.GetActivePersonTypeList, commandType: CommandType.StoredProcedure);
            return data.ToList();
        }

        public async Task<long> ActiveInactivePerson(CommonActiveModel model)
        {
            var param = new DynamicParameters();
            param.Add("@userId", model.UserId);
            param.Add("@id", model.Id);
            param.Add("@tableName", "tbl_Challan");
            param.Add("@columnName", "ChallanId");
            param.Add("@IsActive", model.IsActive);
            return await QueryFirstOrDefaultAsync<long>(StoreProcedure.ActiveInactiveRecord, param, commandType: CommandType.StoredProcedure);
        }

        public async Task<ResponseModel> SaveAttendantPerson(AttendantPersonRequestModel model, string id, string userId)
        {
            var param = new DynamicParameters();
            param.Add("@PersonId", model.PersonId);
            param.Add("@PersonFirstName", model.PersonFirstName);
            param.Add("@PersonAddress", model.PersonAddress);
            param.Add("@MobileNo", model.MobileNo);
            param.Add("@PersonTypeId", model.PersonTypeId);
            param.Add("@DailyRate", model.DailyRate);
            param.Add("@ClientId", id);
            param.Add("@CreatedBy", userId);
            var data = await QueryFirstOrDefaultAsync<ResponseModel>(StoreProcedure.SaveAttendantPerson, param, commandType: CommandType.StoredProcedure);
            return data;
        }
        #endregion
    }
}
