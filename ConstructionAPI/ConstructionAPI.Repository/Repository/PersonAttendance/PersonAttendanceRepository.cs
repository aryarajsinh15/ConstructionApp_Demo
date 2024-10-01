using ConstructionAPI.Common.Helper;
using ConstructionAPI.Model.Config;
using ConstructionAPI.Model.PersonAttendance;
using ConstructionAPI.Model.SiteBill;
using Dapper;
using Microsoft.Extensions.Options;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Repository.Repository.PersonAttendance
{
    public class PersonAttendanceRepository : BaseRepository, IPersonAttendanceRepository
    {

        #region Fields
        #endregion


        #region Constructor
        public PersonAttendanceRepository(IOptions<DataConfig> connectionString) : base(connectionString)
        {
        }
        #endregion

        #region Methods
        public async Task<long> SavePersonAttendance(PersonAttendanceRequestModel model)
        {
            DataTable dtPersonAttendance = new DataTable("tbl_SavePersonAttendance");
            dtPersonAttendance.Columns.Add("PersonAttendanceId", typeof(string));
            dtPersonAttendance.Columns.Add("PersonId", typeof(string));
            dtPersonAttendance.Columns.Add("AttendanceStatus", typeof(decimal));
            dtPersonAttendance.Columns.Add("SiteId", typeof(string));
            dtPersonAttendance.Columns.Add("WithdrawAmount", typeof(int));
            dtPersonAttendance.Columns.Add("OvertimeAmount", typeof(int));
            dtPersonAttendance.Columns.Add("Remarks", typeof(string));
            for (int i = 0; i < model.AttendanceList.Count; i++)
            {
                DataRow dtRow = dtPersonAttendance.NewRow();
                dtRow["PersonAttendanceId"] = model.AttendanceList[i].PersonAttendanceId;
                dtRow["PersonId"] = model.AttendanceList[i].PersonId;
                dtRow["AttendanceStatus"] = model.AttendanceList[i].AttendanceStatus;
                dtRow["SiteId"] = model.AttendanceList[i].SiteId;
                dtRow["WithdrawAmount"] = model.AttendanceList[i].WithdrawAmount;
                dtRow["OvertimeAmount"] = model.AttendanceList[i].OvertimeAmount;
                dtRow["Remarks"] = model.AttendanceList[i].Remarks;
                dtPersonAttendance.Rows.Add(dtRow);
            }
            var param = new DynamicParameters();
            param.Add("@AttendanceId", model.AttendanceId);
            param.Add("@AttendanceDate", model.AttendanceDate);
            param.Add("@ClientId", model.ClientId);
            param.Add("@LoggedId", model.LoggedId);
            param.Add("@tbl_SavePersonAttendance", dtPersonAttendance.AsTableValuedParameter("[dbo].[tbl_SavePersonAttendance]"));

            var result = await QueryFirstOrDefaultAsync<long>(StoreProcedure.SavePersonAttendance, param, commandType: CommandType.StoredProcedure);
            return result;
        }
        
        public async Task<List<PersonAttendanceResponseModel>> PersonAttendanceList(PersonAttendancePagationModel model)
        {
            var param = new DynamicParameters();
            param.Add("@pageIndex",model.PageNumber);
            param.Add("@pageSize",model.PageSize);
            param.Add("@orderBy",model.SortColumn);
            param.Add("@sortOrder",model.SortOrder);
            param.Add("@strSearch",model.StrSearch);
            param.Add("@ClientId",model.ClientId);

            var result = await QueryAsync<PersonAttendanceResponseModel>(StoreProcedure.PersonAttendanceList, param, commandType: CommandType.StoredProcedure);
            return result.ToList();
        }
        public async Task<long> DeletePersonAttendance(string attendanceId, System.Guid? loggedId)
        {
            var param = new DynamicParameters();
            param.Add("@AttendanceId", attendanceId);
            param.Add("@LoggedId", loggedId);
            var result = await QueryFirstOrDefaultAsync<long>(StoreProcedure.DeletePersonAttendance, param, commandType: CommandType.StoredProcedure);
            return result;
        }
        public async Task<PersonAttendanceByIdRequestModel> GetPersonAttendanceById(string attendanceId)
        {
            PersonAttendanceByIdRequestModel result = new PersonAttendanceByIdRequestModel();
            var param = new DynamicParameters();
            param.Add("@AttendanceId", attendanceId);
            string DecryptedConn = EncryptionDecryption.GetDecrypt(_connectionString.Value.DefaultConnection);
            SqlConnection con = new SqlConnection(DecryptedConn);
            using (var multi = await con.QueryMultipleAsync(StoreProcedure.GetPersonAttendanceById, param, commandType: CommandType.StoredProcedure))
            {
                result = multi.Read<PersonAttendanceByIdRequestModel>().FirstOrDefault();
                if (result != null)
                {
                    result.AttendanceList = multi.Read<PersonAttendanceByIdRequestListModel>().ToList();
                }
            }
            return result;
        }
        public async Task<List<AttendanceByPersonResponseModel>> GetAttendanceByPersonId(AttendanceByPersonRequestModel model)
        {
            var param = new DynamicParameters();
            param.Add("@pageIndex", model.PageNumber);
            param.Add("@pageSize", model.PageSize);
            param.Add("@orderBy", model.SortColumn);
            param.Add("@sortOrder", model.SortOrder);
            param.Add("@strSearch", model.StrSearch);
            param.Add("@personId", model.PersonId);
            param.Add("@siteIds", model.SiteIds);
            param.Add("@startDate", model.StartDate);
            param.Add("@endDate", model.EndDate);
            param.Add("@statusIds", model.StatusIds);
            var result = await QueryAsync<AttendanceByPersonResponseModel>(StoreProcedure.GetAttendanceByPerson, param, commandType: CommandType.StoredProcedure);
            return result.ToList();
        }
        #endregion
    }
}
