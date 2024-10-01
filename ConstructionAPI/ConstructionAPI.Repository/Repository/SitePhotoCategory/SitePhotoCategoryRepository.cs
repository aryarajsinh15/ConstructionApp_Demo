using ConstructionAPI.Common.Helper;
using ConstructionAPI.Model.Common;
using ConstructionAPI.Model.Config;
using ConstructionAPI.Model.SitePhotoCategory;
using ConstructionAPI.Model.VehicleOwner;
using Dapper;
using Microsoft.Extensions.Options;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Repository.Repository.SitePhotoCategory
{
    public class SitePhotoCategoryRepository : BaseRepository, ISitePhotoCategoryRepository
    {
        public SitePhotoCategoryRepository(IOptions<DataConfig> connectionString) : base(connectionString)
        {
        }

        public async Task<long> DeleteSitePhotoCategory(Guid sitePhotoCategoryId)
        {
            var param = new DynamicParameters();
            param.Add("@sitePhotoCategoryId", sitePhotoCategoryId);
            return await QueryFirstOrDefaultAsync<long>(StoreProcedure.DeleteSitePhotoCategory, param, commandType: CommandType.StoredProcedure);
        }

        public async Task<List<SitePhotoCategoryListResponseModel>> GetActiveSitePhotoCategoryList(string clientId)
        {
            var param = new DynamicParameters();
            param.Add("@clientId", clientId);
            var data = await QueryAsync<SitePhotoCategoryListResponseModel>(StoreProcedure.GetActiveSitePhotoCategoryList, param, commandType: CommandType.StoredProcedure);
            return data.ToList();
        }

        public async Task<SitePhotoCategoryResponseModel> GetSitePhotoCategoryById(Guid sitePhotoCategoryId)
        {
            var param = new DynamicParameters();
            param.Add("@sitePhotoCategoryId", sitePhotoCategoryId);
            return await QueryFirstOrDefaultAsync<SitePhotoCategoryResponseModel>(StoreProcedure.GetSitePhotoCategoryById, param, commandType: CommandType.StoredProcedure);
        }

        public async Task<List<SitePhotoCategoryListResponseModel>> GetSitePhotoCategoryList(CommonPaginationModel model, string clientId)
        {
            var param = new DynamicParameters();
            param.Add("@pageIndex", model.PageNumber);
            param.Add("@pageSize", model.PageSize);
            param.Add("@orderBy", model.SortColumn);
            param.Add("@sortOrder", model.SortOrder);
            param.Add("@strSearch", model.StrSearch?.Trim());
            param.Add("@clientId", clientId);
            var data = await QueryAsync<SitePhotoCategoryListResponseModel>(StoreProcedure.GetSitePhotoCategoryList, param, commandType: CommandType.StoredProcedure);
            return data.ToList();
        }

        public async Task<long> SaveSitePhotoCategory(SitePhotoCategoryRequestModel model, string clientId)
        {
            var param = new DynamicParameters();
            param.Add("@sitePhotoCategoryId", model.SitePhotoCategoryId);
            param.Add("@categoryName", model.CategoryName);
            param.Add("@clientId", clientId);
            return await QueryFirstOrDefaultAsync<long>(StoreProcedure.SaveSitePhotoCategory, param, commandType: CommandType.StoredProcedure);
        }
    }
}
