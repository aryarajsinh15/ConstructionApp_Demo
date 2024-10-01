using ConstructionAPI.Model.PersonAttendance;
using ConstructionAPI.Repository.Repository.PersonAttendance;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Service.PersonAttendance
{
    public class PersonAttendanceService : IPersonAttendanceService
    {
        #region Fields
        private readonly IPersonAttendanceRepository _personAttendanceRepository;
        #endregion


        #region Constructor
        public PersonAttendanceService(IPersonAttendanceRepository personAttendanceRepository)
        {
            _personAttendanceRepository = personAttendanceRepository;
        }
        #endregion

        #region Methods
        public Task<long> SavePersonAttendance(PersonAttendanceRequestModel model)
        {
            return _personAttendanceRepository.SavePersonAttendance(model);
        }
        public Task<List<PersonAttendanceResponseModel>> PersonAttendanceList(PersonAttendancePagationModel model)
        {
            return _personAttendanceRepository.PersonAttendanceList(model);
        }
        public Task<long> DeletePersonAttendance(string attendanceId, System.Guid? loggedId)
        {
            return _personAttendanceRepository.DeletePersonAttendance(attendanceId,loggedId);
        }
        public Task<PersonAttendanceByIdRequestModel> GetPersonAttendanceById(string attendanceId)
        {
            return _personAttendanceRepository.GetPersonAttendanceById(attendanceId);
        }
        public Task<List<AttendanceByPersonResponseModel>> GetAttendanceByPersonId(AttendanceByPersonRequestModel model)
        {
            return _personAttendanceRepository.GetAttendanceByPersonId(model);
        }
        #endregion
    }
}
