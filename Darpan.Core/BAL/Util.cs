using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using Darpan.Core;

namespace Darpan.Core 
{
    public class Util
    {
        // Ensure your web.config has a connection string named "PanchayatKhabarDBConnection"
        private string connectionString = ConfigurationManager.ConnectionStrings["PanchayatKhabarDBConnection"].ConnectionString;

        // Constructor (optional, but good for initializing)
        public Util()
        {
            // You can add initialization logic here if needed
        }

        // Method to get dashboard data
        public DataSet GetUserDashboard()
        {
            DataSet ds = new DataSet();
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();

                // Query for Total News
                using (SqlCommand cmdNews = new SqlCommand("SELECT COUNT(*) AS TotalNews FROM dbo.News", con))
                {
                    SqlDataAdapter daNews = new SqlDataAdapter(cmdNews);
                    daNews.Fill(ds, "NewsCount"); // Fills ds.Tables[0]
                }

                // Query for Total Gallery Images
                using (SqlCommand cmdGallery = new SqlCommand("SELECT COUNT(*) AS TotalGalleryImages FROM dbo.Gallery", con))
                {
                    SqlDataAdapter daGallery = new SqlDataAdapter(cmdGallery);
                    daGallery.Fill(ds, "GalleryCount"); // Fills ds.Tables[1]
                }

                // Query for Total Categories
                using (SqlCommand cmdCategories = new SqlCommand("SELECT COUNT(*) AS TotalCategories FROM dbo.NewsCategory", con))
                {
                    SqlDataAdapter daCategories = new SqlDataAdapter(cmdCategories);
                    daCategories.Fill(ds, "CategoryCount"); // Fills ds.Tables[2]
                }

                // Query for Total Breaking News ([IsBeaking] = 1)
                using (SqlCommand cmdBreakingNews = new SqlCommand("SELECT COUNT(*) AS TotalBreakingNews FROM dbo.News WHERE IsBeaking = 1", con))
                {
                    SqlDataAdapter daBreakingNews = new SqlDataAdapter(cmdBreakingNews);
                    daBreakingNews.Fill(ds, "BreakingNewsCount"); // Fills ds.Tables[3]
                }

                // Query for Total News By Today (matching Date from [CreatedOn])
                // Uses CONVERT(DATE, ...) to compare only the date part, ignoring time.
                using (SqlCommand cmdNewsToday = new SqlCommand("SELECT COUNT(*) AS TotalNewsToday FROM dbo.News WHERE CONVERT(DATE, CreatedOn) = CONVERT(DATE, GETDATE())", con))
                {
                    SqlDataAdapter daNewsToday = new SqlDataAdapter(cmdNewsToday);
                    daNewsToday.Fill(ds, "NewsTodayCount"); // Fills ds.Tables[4]
                }
            }
            return ds;
        }

        // Method to retrieve login details (hashed password, active status, role) for a given UserId
        public DataTable GetLoginDetails(string userId)
        {
            DataTable dt = new DataTable();
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("SELECT Id, UserId, Password, IsActive, Role FROM dbo.Login WHERE UserId = @UserId", con))
                {
                    cmd.Parameters.AddWithValue("@UserId", userId);
                    con.Open();
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.Fill(dt);
                }
            }
            return dt;
        }

        // Method to add a new admin user (e.g., from CreateUser.aspx)
        // This method takes a plain text password and hashes it before storing.
        public int AddNewAdminUser(string userId, string plainTextPassword, string role)
        {
            string hashedPassword = PasswordHasher.HashPassword(plainTextPassword); // Hash the password!
            int rowsAffected = 0;
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("INSERT INTO dbo.Login (UserId, Password, IsActive, Role) VALUES (@UserId, @Password, 1, @Role)", con))
                {
                    cmd.Parameters.AddWithValue("@UserId", userId);
                    cmd.Parameters.AddWithValue("@Password", hashedPassword);
                    cmd.Parameters.AddWithValue("@Role", role); // e.g., "Admin", "Editor", "Author"
                    con.Open();
                    rowsAffected = cmd.ExecuteNonQuery();
                }
            }
            return rowsAffected;
        }

        // Example: Method to delete a user by Id
        public int DeleteUser(int id)
        {
            int rowsAffected = 0;
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("DELETE FROM dbo.Login WHERE Id = @Id", con))
                {
                    cmd.Parameters.AddWithValue("@Id", id);
                    con.Open();
                    rowsAffected = cmd.ExecuteNonQuery();
                }
            }
            return rowsAffected;
        }

        // You will add more methods here for CRUD operations related to News, Gallery, Ads, etc.
        // based on your application's needs. For example:
        // public int InsertNews(string title, string content, string imageUrl) { ... }
        // public DataTable GetAllNews() { ... }
        // public int UpdateAdvertisement(int adId, string title, string imagePath) { ... }
    }
}