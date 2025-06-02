<%@ Page Title="Cover Story - Panchayat Khabar" Language="C#" MasterPageFile="~/Site1.master" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="Darpan.About" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .cover-story-section {
            background-color: #fff;
            padding: 40px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            margin-bottom: 30px;
            text-align: center;
        }

        .cover-story-section h2 {
            color: #333;
            font-weight: bold;
            margin-bottom: 25px;
            position: relative;
            display: inline-block;
        }

        .cover-story-section h2::after {
            content: '';
            display: block;
            width: 80%;
            height: 3px;
            background-color: #007bff;
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
        .cover-story-image {
            max-width: 100%;
            height: auto;
            margin-bottom: 20px;
            border-radius: 5px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .cover-story-description {
            text-align: justify;
            margin-top: 20px;
        }
        .radio-button-section {
            margin-bottom: 20px;
            /* Center the radio buttons within their section */
            text-align: center; 
        }
        /* New rule for spacing between radio button items */
        .radio-button-section label {
            margin-right: 25px; /* Adjust this value for more/less space */
            font-size: 1.1em;
            cursor: pointer;
        }
        .radio-button-section input[type="radio"] {
            margin-right: 8px;
        }
    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-10">
                <div class="cover-story-section">
                    <h2>Our Cover Story</h2>

                    <div class="radio-button-section">
                        <asp:RadioButtonList ID="rblCoverStoryType" runat="server"
                            RepeatDirection="Horizontal" AutoPostBack="True"
                            OnSelectedIndexChanged="rblCoverStoryType_SelectedIndexChanged">
                            <asp:ListItem Text="Lok Sabha" Value="5" Selected="True"></asp:ListItem>
                            <asp:ListItem Text="Vidhan Sabha" Value="6"></asp:ListItem>
                        </asp:RadioButtonList>
                    </div>

                    <asp:Panel ID="pnlNoContent" runat="server" Visible="false">
                        <div class="no-content-message">
                            <i class="fas fa-exclamation-circle"></i>
                            <p><strong>No Content Available Yet!</strong></p>
                            <p>
                                We are currently working on our latest cover story for the selected category. Please check back soon for exciting updates and in-depth analyses.
                            </p>
                            <p>Thank you for your patience and continued support.</p>
                        </div>
                    </asp:Panel>

                    <asp:Repeater ID="rptCoverStory" runat="server">
                        <ItemTemplate>
                            <h3><%# Eval("Title") %></h3>
                            <p class="text-muted">Published On: <%# Eval("CreatedOn", "{0:dd MMMM yyyy}") %></p>
                            <asp:Image ID="imgCoverStory" runat="server" CssClass="cover-story-image"
                                ImageUrl='<%# GetImageUrl(Eval("ImagePath"), Eval("ThumbPath")) %>'
                                AlternateText='<%# Eval("Title") %>' />
                            <div class="cover-story-description">
                                <p><%# Eval("Discription") %></p>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>

                </div>
            </div>
        </div>
    </div>
</asp:Content>