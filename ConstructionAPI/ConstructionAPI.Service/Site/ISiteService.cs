using ConstructionAPI.Model.Common;
using ConstructionAPI.Model.Site;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Service.Site
{
    public interface ISiteService
    {
        Task<List<SiteListResponseModel>> GetSitesList(SiteListRequestModel model, string clientId);
        Task<long> SaveSites(SiteRequestModel model, System.Guid userId, System.Guid clientId);
        Task<SiteResponseModel> GetSiteById(System.Guid SiteId);
        Task<long> DeleteSite(System.Guid SiteId, System.Guid userId);
        Task<long> DeleteSitePhoto(System.Guid sitePhotoId);
        Task<SiteResponseModel> ActiveInactiveSite(string siteId, System.Guid userId);
        Task<List<ActiveSiteResponseModel>> ActiveSiteList(System.Guid clientId);
        Task<long> AddSiteImages(SiteImageRequestModel model);
        Task<List<SiteImageResponseModel>> SiteImages(string siteId);


    }
}
