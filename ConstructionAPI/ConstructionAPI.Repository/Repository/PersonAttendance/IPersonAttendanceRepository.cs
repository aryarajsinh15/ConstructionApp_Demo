using ConstructionAPI.Model.PersonAttendance;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Repository.Repository.PersonAttendance
{
    public interface IPersonAttendanceRepository
    {
        #region Methods
        Task<long> SavePersonAttendance(PersonAttendanceRequestModel model);
        Task<List<PersonAttendanceResponseModel>> PersonAttendanceList(PersonAttendancePagationModel model);
        Task<long> DeletePersonAttendance(string attendanceId, System.Guid? loggedId);
        Task<PersonAttendanceByIdRequestModel> GetPersonAttendanceById(string attendanceId);
        public Task<List<AttendanceByPersonResponseModel>> GetAttendanceByPersonId(AttendanceByPersonRequestModel model);
        #endregion
    }
}
