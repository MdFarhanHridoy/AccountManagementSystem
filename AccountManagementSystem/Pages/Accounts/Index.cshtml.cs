using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using System.Data;
using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;

public class IndexModel : PageModel
{
    private readonly IConfiguration _configuration;

    public IndexModel(IConfiguration configuration)
    {
        _configuration = configuration;
    }

    public List<Account> Accounts { get; set; } = new List<Account>();

    public class Account
    {
        public int AccountId { get; set; }
        public string AccountCode { get; set; }
        public string AccountName { get; set; }
        public int? ParentAccountId { get; set; }
        public string ParentAccountName { get; set; }
        public string AccountType { get; set; }
    }

    public void OnGet()
    {
        using (SqlConnection connection = new SqlConnection(_configuration.GetConnectionString("DefaultConnection")))
        {
            connection.Open();
            SqlCommand command = new SqlCommand("sp_ManageChartOfAccounts", connection);
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.AddWithValue("@Action", "GetAll");

            using (SqlDataReader reader = command.ExecuteReader())
            {
                while (reader.Read())
                {
                    Accounts.Add(new Account
                    {
                        AccountId = reader.GetInt32(0),
                        AccountCode = reader.GetString(1),
                        AccountName = reader.GetString(2),
                        ParentAccountId = reader.IsDBNull(3) ? (int?)null : reader.GetInt32(3),
                        AccountType = reader.GetString(4)
                    });
                }
            }
        }
    }
}