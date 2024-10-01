using ConstructionAPI.Model.Common;
using ConstructionAPI.Model.Site;
using ConstructionAPI.Repository.Repository.Site;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Service.Site
{
    public class SiteService : ISiteService
    {
        #region Fields
        private readonly ISiteRepository _repository;
        #endregion

        #region Construtor
        public SiteService(ISiteRepository repository)
        {
            _repository = repository;
        }

        #endregion

        #region Methods
        public async Task<long> DeleteSite(System.Guid SiteId, System.Guid userId)
        {
            var result = await _repository.DeleteSite(SiteId, userId);
            return result;
        }

        public async Task<SiteResponseModel> GetSiteById(System.Guid SiteId)
        {
            var result = await _repository.GetSiteById(SiteId);
            return result;
        }

        public async Task<List<SiteListResponseModel>> GetSitesList(SiteListRequestModel model, string clientId)
        {
            var result = await _repository.GetSitesList(model,clientId);
            return result;
        }

        public async Task<long> SaveSites(SiteRequestModel model, System.Guid userId, System.Guid clientId)
        {
            var result = await _repository.SaveSites(model, userId,clientId);;
            return result;
        }

        public async Task<SiteResponseModel> ActiveInactiveSite(string siteId, System.Guid userId)
        {
            var result = await _repository.ActiveInactiveSite(siteId, userId); ;
            return result;
        }

        public async Task<List<ActiveSiteResponseModel>> ActiveSiteList(System.Guid clientId)
        {
            var result = await _repository.ActiveSiteList(clientId); ;
            return result;
        }

        public async Task<long> AddSiteImages(SiteImageRequestModel model)
        {
            var result = await _repository.AddSiteImages(model);
            return result;
        }

        public async Task<List<SiteImageResponseModel>> SiteImages(string siteId)
        {
            var result = await _repository.SiteImages(siteId); 
            return result;
        }

        public async Task<long> DeleteSitePhoto(Guid sitePhotoId)
        {
            var result = await _repository.DeleteSitePhoto(sitePhotoId);
            return result;
        }
        #endregion
    }
}
