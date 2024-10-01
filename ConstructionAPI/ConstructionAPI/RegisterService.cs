using ConstructionAPI.Repository;
using ConstructionAPI.Service;
using ConstructionAPI.Service.JWTAuthentication;

namespace ConstructionAPI
{
    public static class RegisterService
    {
        public static void RegisterServices(this IServiceCollection services)
        {
            Configure(services, RepositoryRegister.GetTypes());
            Configure(services, ServiceRegister.GetTypes());
        }
        private static void Configure(IServiceCollection services, Dictionary<Type, Type> types)
        {
            foreach (var type in types)
                services.AddScoped(type.Key, type.Value);
        }

        public static void ConfigureLoggerService(this IServiceCollection services)
        {
            
        }
    }
}
