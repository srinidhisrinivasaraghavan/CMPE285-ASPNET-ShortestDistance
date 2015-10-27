using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(HAS.Startup))]
namespace HAS
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
