using Baladiti.Models;
using Microsoft.EntityFrameworkCore;

namespace Baladiti.Data
{
    public class AppDBcontext : DbContext
    {

        public AppDBcontext(DbContextOptions<AppDBcontext> options) : base(options)
        {
        }

        public DbSet<User> Users { get; set; }
        public DbSet<Report> Reports { get; set; }




    }
}
