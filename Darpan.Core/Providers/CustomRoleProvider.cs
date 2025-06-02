using System;
using System.Linq; // For .Contains()
using System.Web.Security;
using System.Collections.Specialized;
using System.Configuration.Provider;
using System.Data;
using System.Data.SqlClient;
using System.Configuration; // For ConfigurationManager

namespace Darpan.Core.Providers // IMPORTANT: Namespace changed from Darpan.Providers to Darpan.Core
{
    public class CustomRoleProvider : RoleProvider
    {
        private string connectionString; // This field will store the actual connection string value
        private string _connectionStringName; // A new field to store the name of the connection string

        public override void Initialize(string name, NameValueCollection config)
        {
            if (config == null)
                throw new ArgumentNullException("config");

            if (string.IsNullOrEmpty(name))
                name = "CustomRoleProvider";

            if (string.IsNullOrEmpty(config["description"]))
            {
                config.Remove("description");
                config.Add("description", "Custom Role Provider for Darpan Admin");
            }

            // Always call base.Initialize first
            base.Initialize(name, config);

            // Get the connection string name from the 'config' collection passed by ASP.NET
            // This is the attribute specified in web.config like connectionStringName="PanchayatKhabarDBConnection"
            _connectionStringName = config["connectionStringName"];

            if (string.IsNullOrEmpty(_connectionStringName))
                throw new ProviderException("The 'connectionStringName' attribute cannot be empty in the roleManager configuration.");

            // Now use the retrieved name (_connectionStringName) to get the actual connection string value
            ConnectionStringSettings connectionSettings = ConfigurationManager.ConnectionStrings[_connectionStringName];

            if (connectionSettings == null || string.IsNullOrEmpty(connectionSettings.ConnectionString))
                throw new ProviderException($"Connection string specified by '{_connectionStringName}' is not found or is empty.");

            connectionString = connectionSettings.ConnectionString;
        }

        // This is the most important method for Forms Authentication to work with roles.
        // It's called by ASP.NET when it needs to determine the roles of the current user.
        public override string[] GetRolesForUser(string username)
        {
            string role = null;
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("SELECT Role FROM dbo.Login WHERE UserId = @UserId AND IsActive = 1", con))
                {
                    cmd.Parameters.AddWithValue("@UserId", username);
                    con.Open();
                    object result = cmd.ExecuteScalar();
                    if (result != null)
                    {
                        role = result.ToString();
                    }
                }
            }
            if (!string.IsNullOrEmpty(role))
            {
                return new string[] { role }; // Return an array with the single role
            }
            return new string[] { }; // Return empty array if no role found or user not active
        }

        // You generally only need to implement the methods that are actually called by your application.
        // For simple Forms Authentication and web.config authorization, GetRolesForUser is key.
        // The others can throw NotImplementedException if you don't use them.
        public override bool IsUserInRole(string username, string roleName)
        {
            // Simple check: is the given roleName present in the roles returned by GetRolesForUser
            return GetRolesForUser(username).Contains(roleName);
        }

        // Mandatory abstract properties/methods, implement them minimally if not fully used
        public override string ApplicationName { get; set; } = "/"; // Set default application name
        public override void AddUsersToRoles(string[] usernames, string[] roleNames) { throw new NotImplementedException(); }
        public override bool DeleteRole(string roleName, bool throwOnPopulatedRole) { throw new NotImplementedException(); }
        public override string[] FindUsersInRole(string roleName, string usernameToMatch) { throw new NotImplementedException(); }
        public override string[] GetAllRoles() { throw new NotImplementedException(); }
        public override string[] GetUsersInRole(string roleName) { throw new NotImplementedException(); }
        public override void RemoveUsersFromRoles(string[] usernames, string[] roleNames) { throw new NotImplementedException(); }
        public override bool RoleExists(string roleName) { throw new NotImplementedException(); }
        public override void CreateRole(string roleName) { throw new NotImplementedException(); }
    }
}