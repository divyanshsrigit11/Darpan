using BCrypt.Net; // This using directive is essential after installing the NuGet package

namespace Darpan.Core.Security // IMPORTANT: Namespace changed from Darpan.Security to Darpan.Core
{
    public static class PasswordHasher
    {
        // Hashes a plain text password using BCrypt.
        // BCrypt automatically handles salting (adding random data to the password before hashing)
        // and iterating (performing the hash calculation multiple times) which makes it very secure.
        // 'workFactor' determines the computational cost: higher value = more secure but slower hash.
        // A work factor of 12 is generally a good balance for modern systems.
        public static string HashPassword(string password)
        {
            return BCrypt.Net.BCrypt.HashPassword(password, workFactor: 12);
        }

        // Verifies a plain text password against a stored BCrypt hash.
        // It internally hashes the provided password and compares it with the stored hash.
        public static bool VerifyPassword(string password, string hashedPassword)
        {
            // BCrypt.Verify returns true if the password matches the hash, false otherwise.
            return BCrypt.Net.BCrypt.Verify(password, hashedPassword);
        }
    }
}