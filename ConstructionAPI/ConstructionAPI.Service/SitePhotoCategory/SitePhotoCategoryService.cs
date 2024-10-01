using ConstructionAPI.Model.Common;
using ConstructionAPI.Model.SitePhotoCategory;
using ConstructionAPI.Repository.Repository.Site;
using ConstructionAPI.Repository.Repository.SitePhotoCategory;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Service.SitePhotoCategory
{
    public class SitePhotoCategoryService : ISitePhotoCategoryService
    {
        #region Fields
        private readonly ISitePhotoCategoryRepository _repository;
        #endregion

        #region Construtor
        public SitePhotoCategoryService(ISitePhotoCategoryRepository repository)
        {
            _repository = repository;
        }

        #endregion

        public async Task<long> DeleteSitePhotoCategory(Guid sitePhotoCategoryId)
        {
            return await _repository.DeleteSitePhotoCategory(sitePhotoCategoryId);
        }

        public async Task<List<SitePhotoCategoryListResponseModel>> GetActiveSitePhotoCategoryList(string clientId)
        {
            return await _repository.GetActiveSitePhotoCategoryList(clientId);
        }

        public async Task<SitePhotoCategoryResponseModel> GetSitePhotoCategoryById(Guid sitePhotoCategoryId)
        {
            return await _repository.GetSitePhotoCategoryById(sitePhotoCategoryId);
        }

        public async Task<List<SitePhotoCategoryListResponseModel>> GetSitePhotoCategoryList(CommonPaginationModel model, string clientId)
        {
            return await _repository.GetSitePhotoCategoryList(model, clientId);
        }

        public async Task<long> SaveSitePhotoCategory(SitePhotoCategoryRequestModel model, string clientId)
        {
            return await _repository.SaveSitePhotoCategory(model, clientId);
        }
    }
}
