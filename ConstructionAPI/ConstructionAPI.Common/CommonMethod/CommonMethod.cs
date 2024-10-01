using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConstructionAPI.Common.CommonMethod
{
    public class CommonMethod
    {
        public static async Task<string> UploadImage(IFormFile file, string Filepath)
        {
            Guid guidFile = Guid.NewGuid();
            string FileName;
            string BasePath;
            string path;
            string Photo = string.Empty;
            FileName = guidFile + Path.GetExtension(file.FileName);
            BasePath = Path.Combine(Directory.GetCurrentDirectory(), Filepath);
            if (!Directory.Exists(BasePath))
            {
                Directory.CreateDirectory(BasePath);
            }
            path = Path.Combine(BasePath, FileName);
            using (FileStream stream = new FileStream(path, FileMode.Create))
            {
                await file.CopyToAsync(stream);
            }
            Photo = FileName;
            return Photo;
        }

    }
}
