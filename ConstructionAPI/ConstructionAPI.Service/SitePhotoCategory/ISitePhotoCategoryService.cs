using ConstructionAPI.Model.Common;
using ConstructionAPI.Model.SitePhotoCategory;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Service.SitePhotoCategory
{
    public interface ISitePhotoCategoryService
    {
        Task<List<SitePhotoCategoryListResponseModel>> GetSitePhotoCategoryList(CommonPaginationModel model, string clientId);
        Task<long> DeleteSitePhotoCategory(System.Guid sitePhotoCategoryId);
        Task<SitePhotoCategoryResponseModel> GetSitePhotoCategoryById(System.Guid sitePhotoCategoryId);
        Task<long> SaveSitePhotoCategory(SitePhotoCategoryRequestModel model, string clientId);
        Task<List<SitePhotoCategoryListResponseModel>> GetActiveSitePhotoCategoryList(string clientId);

    }
}
