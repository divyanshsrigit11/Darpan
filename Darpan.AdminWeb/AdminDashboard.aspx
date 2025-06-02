<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminDashboard.aspx.cs" Inherits="Darpan.AdminWeb.AdminDashboard" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Darpan The Mirror</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="style.css" rel="stylesheet"> <%-- Assuming style.css is now in the Darpan.AdminWeb root --%>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f7f6;
        }
        .dashboard-header {
            background-color: #007bff;
            color: white;
            padding: 20px 0;
            text-align: center;
            margin-bottom: 30px;
        }
        .card {
            border: none;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            margin-bottom: 20px;
        }
        .card-body {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            padding: 25px;
        }
        .card-title {
            font-size: 1.1em;
            color: #555;
            margin-bottom: 15px;
        }
        .card-value {
            font-size: 2.5em;
            font-weight: bold;
            color: #007bff;
        }
        .card-icon {
            font-size: 2em;
            margin-bottom: 10px;
            color: #007bff;
        }
        /* Example icons - you might use Font Awesome or similar */
        .icon-news::before { content: "📰"; }
        .icon-gallery::before { content: "🖼️"; }
        .icon-categories::before { content: "🗂️"; }
        .icon-breaking::before { content: "⚡"; }
        .icon-ads::before { content: "📢"; }
        .icon-users::before { content: "👥"; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="dashboard-header">
            <h1>Admin Dashboard</h1>
            <p>Welcome to your control panel</p>
        </div>

        <div class="container">
            <div class="row">
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-body">
                            <div class="card-icon icon-news"></div>
                            <h5 class="card-title">Total News</h5>
                            <span class="card-value" runat="server" id="lblTotalNews">0</span>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-body">
                            <div class="card-icon icon-gallery"></div>
                            <h5 class="card-title">Total Gallery Images</h5>
                            <span class="card-value" runat="server" id="lblTotalGallery">0</span>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-body">
                            <div class="card-icon icon-categories"></div>
                            <h5 class="card-title">Total Categories</h5>
                            <span class="card-value" runat="server" id="lblTotalCategries">0</span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-body">
                            <div class="card-icon icon-breaking"></div>
                            <h5 class="card-title">Total Breaking News</h5>
                            <span class="card-value" runat="server" id="lblTotalBrking">0</span>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-body">
                            <div class="card-icon icon-ads"></div>
                            <h5 class="card-title">Total Advertisements</h5>
                            <span class="card-value" runat="server" id="lblTotalAds">0</span>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-body">
                            <div class="card-icon icon-users"></div>
                            <h5 class="card-title">Total Users</h5>
                            <span class="card-value" runat="server" id="lblTotalUsers">0</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
