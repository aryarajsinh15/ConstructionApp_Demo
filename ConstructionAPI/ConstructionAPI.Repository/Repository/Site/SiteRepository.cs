using ConstructionAPI.Common.Helper;
using ConstructionAPI.Model.Common;
using ConstructionAPI.Model.Config;
using ConstructionAPI.Model.Site;
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

namespace ConstructionAPI.Repository.Repository.Site
{
    public class SiteRepository : BaseRepository, ISiteRepository
    {
        public SiteRepository(IOptions<DataConfig> dataConfig) : base(dataConfig)
        { }

        public async Task<SiteResponseModel> ActiveInactiveSite(string siteId, Guid userId)
        {
            var param = new DynamicParameters();
            param.Add("@SiteId", siteId);
            param.Add("@userId", userId);
            return await QueryFirstOrDefaultAsync<SiteResponseModel>(StoreProcedure.ActiveInActiveSite, param, commandType: CommandType.StoredProcedure);
        }

        public async Task<List<ActiveSiteResponseModel>> ActiveSiteList(System.Guid clientId)
        {
            var param = new DynamicParameters();
            param.Add("@clientId", clientId);
            var data = await QueryAsync<ActiveSiteResponseModel>(StoreProcedure.ActiveSiteList, param,commandType: CommandType.StoredProcedure);
            return data.ToList();
        }

        public async Task<long> DeleteSite(System.Guid SiteId, System.Guid userId)
        {
            var param = new DynamicParameters();
            param.Add("@SiteId", SiteId);
            param.Add("@userId", userId);
            return await QueryFirstOrDefaultAsync<long>(StoreProcedure.DeleteSite, param, commandType: CommandType.StoredProcedure);
        }

        public async Task<SiteResponseModel> GetSiteById(Guid SiteId)
        {
            var param = new DynamicParameters();
            param.Add("@SiteId", SiteId);
            return await QueryFirstOrDefaultAsync<SiteResponseModel>(StoreProcedure.GetSiteById, param, commandType: CommandType.StoredProcedure);
        }

        public async Task<List<SiteListResponseModel>> GetSitesList(SiteListRequestModel model, string clientId)
        {
            var param = new DynamicParameters();
            param.Add("@pageIndex", model.PageNumber);
            param.Add("@pageSize", model.PageSize);
            param.Add("@orderBy", model.SortColumn);
            param.Add("@sortOrder", model.SortOrder);
            param.Add("@strSearch", model.StrSearch?.Trim());
            param.Add("@clientId", clientId);
            param.Add("@startDate", model.StartDate);
            param.Add("@endDate", model.EndDate);
            param.Add("@activeInActiveStatus", model.ActiveInActiveStatus);
            var data = await QueryAsync<SiteListResponseModel>(StoreProcedure.GetSiteList, param, commandType: CommandType.StoredProcedure);
            return data.ToList();
        }

        public async Task<long> SaveSites(SiteRequestModel model, System.Guid userId, System.Guid clientId)
        {
            var param = new DynamicParameters();
            param.Add("@SiteId", model.SiteId);
            param.Add("@SiteName", model.SiteName);
            param.Add("@SiteDescription", model.SiteDescription);
            param.Add("@CreatedBy", userId);
            param.Add("@clientId", clientId);
            return await QueryFirstOrDefaultAsync<long>(StoreProcedure.SaveSite, param, commandType: CommandType.StoredProcedure);
        }

        public async Task<long> AddSiteImages(SiteImageRequestModel model)
        {
            DataTable siteImages = new DataTable("tbl_SitePhotos");
            siteImages.Columns.Add("PhotoName");
            siteImages.Columns.Add("PhotoEncryptedName");
            if (model.SiteImage != null && model.SiteImage.Count > 0)
            {
                foreach (var item in model.SiteImage)
                {
                    DataRow dtRow = siteImages.NewRow();
                    if ((item.ImageFileOriginalName != null || item.ImageFileOriginalName != "") && (item.ImageFileEncryptedName != null || item.ImageFileEncryptedName != ""))
                    {
                        dtRow["PhotoName"] = item.ImageFileOriginalName;
                        dtRow["PhotoEncryptedName"] = item.ImageFileEncryptedName;
                    }
                    siteImages.Rows.Add(dtRow);
                }
            }
            var param = new DynamicParameters();
            param.Add("@siteId", model.SiteId);
            param.Add("@categoryId", model.SiteCategoryId);
            param.Add("@siteImages", siteImages.AsTableValuedParameter("[dbo].[tbl_SitePhotos]"));
            return await QueryFirstOrDefaultAsync<long>(StoreProcedure.SaveSitePhoto, param, commandType: CommandType.StoredProcedure);
        }

        public async Task<List<SiteImageResponseModel>> SiteImages(string siteId)
        {
            List<SiteImageResponseModel> result = new List<SiteImageResponseModel>();
            var param = new DynamicParameters();
            param.Add("@siteId", siteId);
            string DecryptedConn = EncryptionDecryption.GetDecrypt(_connectionString.Value.DefaultConnection);
            SqlConnection con = new SqlConnection(DecryptedConn);
            using (var multi = await con.QueryMultipleAsync(StoreProcedure.GetSitePhoto, param, commandType: CommandType.StoredProcedure))
            {
                result = multi.Read<SiteImageResponseModel>().ToList();
                var list = multi.Read<SiteImage>().ToList();
                for (int i = 0; i < result.Count; i++)
                {
                    result[i].Images = list.Where(x=> x.SitePhotoCategoryId == result[i].SitePhotoCategoryId).ToList();
                }
               
            }
            return result;
        }

        public async Task<long> DeleteSitePhoto(Guid sitePhotoId)
        {
            var param = new DynamicParameters();
            param.Add("@sitePhotoId", sitePhotoId);
            return await QueryFirstOrDefaultAsync<long>(StoreProcedure.DeleteSitePhoto, param, commandType: CommandType.StoredProcedure);
        }
    }
}