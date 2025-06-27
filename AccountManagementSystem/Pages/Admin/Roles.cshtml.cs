using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.AspNetCore.Identity;

public class RolesModel : PageModel
{
    private readonly RoleManager<IdentityRole> _roleManager;

    public RolesModel(RoleManager<IdentityRole> roleManager)
    {
        _roleManager = roleManager;
    }

    public IList<IdentityRole> Roles { get; set; }

    public async Task OnGetAsync()
    {
        Roles = _roleManager.Roles.ToList();
    }

    public async Task<IActionResult> OnPostCreateAsync(string roleName)
    {
        if (!string.IsNullOrEmpty(roleName))
        {
            await _roleManager.CreateAsync(new IdentityRole(roleName.Trim()));
        }
        return RedirectToPage();
    }
}