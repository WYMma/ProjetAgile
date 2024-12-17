
using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace Baladiti.Models
{
    public class Report
    {
        [Key] 
        public int Id { get; set; }

        [Required] 
        [ForeignKey("User")] 
        public int UserId { get; set; }

        public User User { get; set; }

        [Required] 
        [MaxLength(100)] 
        public string Name { get; set; }

        [MaxLength(500)] 
        public string Description { get; set; }

        [Required]
        public DateTime CreationDate { get; set; }

        [MaxLength(255)] 
        public string ImagePath { get; set; }

        [MaxLength(100)] 
        public string Place { get; set; }

        [MaxLength(50)] 
        public string Status { get; set; }
    }
}
