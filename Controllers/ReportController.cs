using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Baladiti.Data;
using Baladiti.Models;

namespace Baladiti.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ReportsController : ControllerBase
    {
        private readonly AppDBcontext _context;

        public ReportsController(AppDBcontext context)
        {
            _context = context;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<Report>>> GetReports()
        {
            return await _context.Reports.Include(r => r.User).ToListAsync();
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<Report>> GetReport(int id)
        {
            var report = await _context.Reports.Include(r => r.User).FirstOrDefaultAsync(r => r.Id == id);

            if (report == null)
            {
                return NotFound();
            }

            return report;
        }

        [HttpGet("User/{userId}")]
        public async Task<ActionResult<IEnumerable<Report>>> GetReportsByUserId(int userId)
        {
            // Vérifier si l'utilisateur existe
            var user = await _context.Users.FindAsync(userId);
            if (user == null)
            {
                return NotFound("L'utilisateur associé n'existe pas.");
            }

            // Récupérer les rapports pour cet utilisateur
            var reports = await _context.Reports
                .Where(r => r.UserId == userId)
                .ToListAsync();

            // Vérifier si des rapports existent pour cet utilisateur
            if (reports == null || reports.Count == 0)
            {
                return NotFound("Aucun rapport trouvé pour cet utilisateur.");
            }

            return Ok(reports);
        }

        [HttpPost]
        public async Task<ActionResult<Report>> CreateReport([FromForm] int userId,[FromForm] string name,[FromForm] string description,[FromForm] string place,[FromForm] string status,IFormFile image)
        {
            if (image == null || image.Length == 0)
            {
                return BadRequest("L'image n'est pas téléchargée ou est vide.");
            }

            var user = await _context.Users.FindAsync(userId);
            if (user == null)
            {
                return NotFound("L'utilisateur associé n'existe pas.");
            }

            var fileName = Path.GetFileName(image.FileName);
            var uploadsFolder = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", "images");
            var filePath = Path.Combine(uploadsFolder, fileName);

            Directory.CreateDirectory(uploadsFolder);

            using (var stream = new FileStream(filePath, FileMode.Create))
            {
                await image.CopyToAsync(stream);
            }

            var report = new Report
            {
                UserId = userId,
                Name = name,
                Description = description,
                Place = place,
                Status = "en cours",
                ImagePath = $"/images/{fileName}",
                CreationDate = DateTime.Now
            };

            _context.Reports.Add(report);
            await _context.SaveChangesAsync();

            return CreatedAtAction(nameof(CreateReport), new { id = report.Id }, report);
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> UpdateReport(int id, Report report)
        {
            if (id != report.Id)
            {
                return BadRequest();
            }

            var existingReport = await _context.Reports.FindAsync(id);
            if (existingReport == null)
            {
                return NotFound();
            }

            existingReport.Name = report.Name;
            existingReport.Description = report.Description;
            existingReport.ImagePath = report.ImagePath;
            existingReport.Place = report.Place;
            existingReport.Status = report.Status;
            existingReport.CreationDate = report.CreationDate;

            _context.Entry(existingReport).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!_context.Reports.Any(e => e.Id == id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return NoContent();
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteReport(int id)
        {
            var report = await _context.Reports.FindAsync(id);
            if (report == null)
            {
                return NotFound();
            }

            _context.Reports.Remove(report);
            await _context.SaveChangesAsync();

            return NoContent();
        }
    }
}
