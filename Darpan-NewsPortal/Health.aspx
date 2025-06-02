<%@ Page Title="Health - Panchayat Khabar" Language="C#" MasterPageFile="~/Site1.master" AutoEventWireup="true" CodeBehind="Health.aspx.cs" Inherits="Darpan.Health" %>

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
            background-color: #17a2b8; /* Teal for Health */
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
            color: #ffc107; /* Warning yellow */
            margin-bottom: 15px;
            display: block;
        }
        .news-article-image {
            max-width: 100%;
            height: auto;
            margin-bottom: 20px;
            border-radius: 5px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .news-article-description {
            text-align: justify;
            margin-top: 20px;
        }
    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-10">
                <div class="category-section">
                    <h2>Health & Wellness</h2>

                    <asp:Panel ID="pnlNoContent" runat="server" Visible="false">
                        <div class="no-content-message">
                            <i class="fas fa-exclamation-circle"></i>
                            <p><strong>No Health Content Available Yet!</strong></p>
                            <p>
                                We are compiling important information, tips, and news related to health and wellness. Your well-being is our priority.
                            </p>
                            <p>Thank you for your patience.</p>
                        </div>
                    </asp:Panel>

                    <asp:Repeater ID="rptNewsArticles" runat="server">
                        <ItemTemplate>
                            <h3><%# Eval("Title") %></h3>
                            <p class="text-muted">Published On: <%# Eval("CreatedOn", "{0:dd MMMMyyyy}") %></p>
                            <asp:Image ID="imgArticle" runat="server" CssClass="news-article-image"
                                ImageUrl='<%# GetImageUrl(Eval("ImagePath"), Eval("ThumbPath")) %>'
                                AlternateText='<%# Eval("Title") %>' />
                            <div class="news-article-description">
                                <p><%# Eval("Discription") %></p>
                            </div>
                            <hr /> <%-- Separator between articles --%>
                        </ItemTemplate>
                    </asp:Repeater>

                </div>
            </div>
        </div>
    </div>
</asp:Content>