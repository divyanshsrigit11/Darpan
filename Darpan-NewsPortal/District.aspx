<%@ Page Title="District News - Panchayat Khabar" Language="C#" MasterPageFile="~/Site1.master" AutoEventWireup="true" CodeBehind="District.aspx.cs" Inherits="Darpan.District" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .district-selection-section {
            background-color: #fff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            margin-bottom: 30px;
            text-align: center; /* Center content within this section */
        }

        .district-selection-section h2 {
            color: #333;
            font-weight: bold;
            margin-bottom: 25px;
            position: relative;
            display: inline-block;
        }

        .district-selection-section h2::after {
            content: '';
            display: block;
            width: 80%;
            height: 3px;
            background-color: #007bff;
            margin: 10px auto 0;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .news-results-section {
            margin-top: 30px;
            background-color: #f8f9fa;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
        }

        .news-item {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
            margin-bottom: 20px;
            text-align: left; /* Align news content left */
        }

        .news-item h3 {
            color: #007bff;
            margin-bottom: 10px;
            font-size: 1.5rem;
        }

        .news-item .news-meta {
            font-size: 0.9rem;
            color: #777;
            margin-bottom: 15px;
        }

        .news-item .news-image {
            max-width: 100%;
            height: auto;
            border-radius: 5px;
            margin-bottom: 15px;
        }

        .news-item p {
            font-size: 1rem;
            line-height: 1.6;
            color: #444;
            text-align: justify;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="district-selection-section">
                    <h2>Select Your District to View News</h2>
                    <div class="form-group">
                        <label for="ddlDistricts" class="font-weight-bold mb-2">Choose District:</label>
                        <asp:DropDownList ID="ddlDistricts" runat="server" CssClass="form-control"
                            AutoPostBack="True" OnSelectedIndexChanged="ddlDistricts_SelectedIndexChanged">
                            <asp:ListItem Text="-- Select District --" Value="0"></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>

                <div class="news-results-section">
                    <h3>News for <asp:Literal ID="litSelectedDistrict" runat="server"></asp:Literal></h3>
                    <hr />

                    <asp:Panel ID="pnlNoNewsMessage" runat="server" CssClass="alert alert-info text-center" Visible="true">
                        Please select a district to see news.
                    </asp:Panel>

                    <asp:Repeater ID="rptDistrictNews" runat="server">
                        <ItemTemplate>
                            <div class="news-item">
                                <h3><%# Eval("Title") %></h3>
                                <div class="news-meta">
                                    Published on <%# Eval("CreatedOn", "{0:dd MMMyyyy}") %> | By <span class="author"><%# Eval("author_editorid") %></span>
                                </div>
                                <asp:Image ID="imgNews" runat="server" CssClass="news-image"
                                    ImageUrl='<%# GetImageUrl(Eval("ImagePath"), Eval("ThumbPath")) %>' />
                                <p><%# Eval("Discription") %></p>
                                <%-- You can add a "Read More" link here if you have a separate detail page for news --%>
                            </div>
                        </ItemTemplate>
                        <FooterTemplate>
                            <%-- This content shows if the Repeater is empty --%>
                            <asp:Panel ID="pnlNoDataFound" runat="server" Visible='<%# rptDistrictNews.Items.Count == 0 %>'>
                                <div class="alert alert-warning text-center">No news found for this district yet.</div>
                            </asp:Panel>
                        </FooterTemplate>
                    </asp:Repeater>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
