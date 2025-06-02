<%@ Page Title="Film Stars - Panchayat Khabar" Language="C#" MasterPageFile="~/Site1.master" AutoEventWireup="true" CodeBehind="FilmStars.aspx.cs" Inherits="Darpan.FilmStars" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .category-section {
            background-color: #fff;
            padding: 40px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            margin-bottom: 30px;
            text-align: center;
        }

        .category-section h2 {
            color: #333;
            font-weight: bold;
            margin-bottom: 25px;
            position: relative;
            display: inline-block;
        }

        .category-section h2::after {
            content: '';
            display: block;
            width: 80%;
            height: 3px;
            background-color: #6c757d;
            margin: 10px auto 0;
        }

        .no-content-message {
            padding: 30px;
            background-color: #f8f9fa;
            border: 1px solid #dee2e6;
            border-radius: 8px;
            color: #6c757d;
            font-size: 1.2rem;
            text-align: center;
            margin-top: 20px;
        }
        .no-content-message i {
            font-size: 2.5rem;
            color: #ffc107;
            margin-bottom: 15px;
            display: block;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-10">
                <div class="category-section">
                    <h2>Film Stars News</h2>
                    <div class="no-content-message">
                        <i class="fas fa-exclamation-circle"></i>
                        <p><strong>No Film Stars Content Available Yet!</strong></p>
                        <p>
                            We are gathering the latest updates and stories about your favorite film stars. Please check back soon for entertainment news.
                        </p>
                        <p>Thank you for your patience.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>