using System;
using System.Configuration; 
using System.Data.SqlClient; 
using System.Net.Http; 
using System.Threading.Tasks;
using System.Web.UI; 

namespace Darpan
{
    public partial class Contact : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
           
        }

        protected async void btnSubmit_Click(object sender, EventArgs e)
        {
            if (IsValid) // Basic validation if you have validators, or just check Request.HttpMethod == "POST"
            {
                string name = txtName.Text.Trim();
                string email = txtEmail.Text.Trim();
                string subject = txtSubject.Text.Trim();
                string message = txtMessage.Text.Trim();

                bool dbSuccess = false;
                bool formspreeSuccess = false;

                // 1. Store data in SQL Server
                string connectionString = ConfigurationManager.ConnectionStrings["PanchayatKhabarDBConnection"].ConnectionString;

                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    // >>>>>>>>>> THE CHANGE IS HERE <<<<<<<<<<
                    string query = @"INSERT INTO ContactMessages (Name, Email, Subject, Message, SubmissionDate)
                                            VALUES (@Name, @Email, @Subject, @Message, GETDATE())";
                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@Name", name);
                        cmd.Parameters.AddWithValue("@Email", email);
                        cmd.Parameters.AddWithValue("@Subject", subject);
                        cmd.Parameters.AddWithValue("@Message", message);

                        try
                        {
                            con.Open();
                            int rowsAffected = cmd.ExecuteNonQuery();
                            if (rowsAffected > 0)
                            {
                                dbSuccess = true;
                                litMessage.Text = "<div class='alert alert-success mt-3'>Your message has been saved successfully!</div>";
                                // Clear form fields
                                txtName.Text = "";
                                txtEmail.Text = "";
                                txtSubject.Text = "";
                                txtMessage.Text = "";
                            }
                            else
                            {
                                litMessage.Text = "<div class='alert alert-warning mt-3'>Failed to save your message. Please try again.</div>";
                            }
                        }
                        catch (Exception ex)
                        {
                            litMessage.Text = $"<div class='alert alert-danger mt-3'>An error occurred while saving your message: {ex.Message}</div>";
                            // Log the exception (e.g., to a file or logging service)
                            // Console.WriteLine($"Database Error: {ex.Message}");
                        }
                    }
                }

                // 2. (Optional) Send data to Formspree for email delivery
                // Replace "YOUR_FORMSPREE_FORM_ID" with your actual Formspree form ID
                string formspreeEndpoint = "https://formspree.io/f/xjkwqoeb";
                if (!string.IsNullOrEmpty(formspreeEndpoint) && formspreeEndpoint.Contains("formspree.io")) // Basic check
                {
                    try
                    {
                        using (var client = new HttpClient())
                        {
                            var values = new System.Collections.Generic.Dictionary<string, string>
                            {
                                { "name", name },
                                { "email", email },
                                { "_subject", subject },
                                { "message", message }
                            };

                            var content = new FormUrlEncodedContent(values);
                            var response = await client.PostAsync(formspreeEndpoint, content);

                            if (response.IsSuccessStatusCode)
                            {
                                formspreeSuccess = true;
                                // If you want separate messages for DB and Formspree:
                                // litMessage.Text += "<div class='alert alert-info mt-1'>And sent via email successfully!</div>";
                            }
                            else
                            {
                                // Handle Formspree failure, e.g., log it
                                // litMessage.Text += "<div class='alert alert-warning mt-1'>Failed to send email via Formspree.</div>";
                                // Console.WriteLine($"Formspree Error: {response.StatusCode} - {await response.Content.ReadAsStringAsync()}");
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        // Handle network or other errors related to Formspree submission
                        // litMessage.Text += $"<div class='alert alert-danger mt-1'>Error sending to Formspree: {ex.Message}</div>";
                        // Console.WriteLine($"Formspree Exception: {ex.Message}");
                    }
                }

                // Adjust your success message based on both operations if desired
                if (dbSuccess && formspreeSuccess)
                {
                    litMessage.Text = "<div class='alert alert-success mt-3'>Your message has been saved and sent via email successfully!</div>";
                }
                else if (dbSuccess && !formspreeSuccess)
                {
                    litMessage.Text = "<div class='alert alert-warning mt-3'>Your message has been saved, but there was an issue sending the email.</div>";
                }
                // If dbSuccess was false, the error message is already set.
            }
        }
    }
}