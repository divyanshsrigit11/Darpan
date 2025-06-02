<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Darpan.AdminWeb.Login" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Login - Darpan The Mirror</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="style.css" rel="stylesheet"> <%-- Assuming style.css is now in the Darpan.AdminWeb root --%>
    <style>
        /* Specific styles for the login page */
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            background-color: #f0f2f5; /* Light background */
        }
        .login-container {
            background-color: #fff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 400px; /* Max width for the login form */
        }
        .login-container h2 {
            margin-bottom: 25px;
            color: #333;
            text-align: center;
        }
        .login-container .form-label {
            font-weight: bold;
        }
        .login-container .btn-primary {
            width: 100%; /* Full width button */
            padding: 10px;
            font-size: 1.1em;
            background-color: #007bff;
            border-color: #007bff;
        }
        .login-container .btn-primary:hover {
            background-color: #0056b3;
            border-color: #0056b3;
        }
        .login-message {
            margin-top: 15px;
            text-align: center;
            color: red;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <form id="formLogin" runat="server" class="login-container">
        <h2>Admin Login (Auth Free Test)</h2>
        <div class="mb-3">
            <label for="txtUsername" class="form-label">Username</label>
            <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" placeholder="Enter username (ignored)"></asp:TextBox>
        </div>
        <div class="mb-4">
            <label for="txtPassword" class="form-label">Password</label>
            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control" placeholder="Enter password (ignored)"></asp:TextBox>
        </div>
        <asp:Button ID="btnLogin" runat="server" Text="Login to Dashboard" CssClass="btn btn-primary" OnClick="btnLogin_Click" />
        <asp:Label ID="lblMessage" runat="server" CssClass="login-message" EnableViewState="false"></asp:Label>
    </form>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
