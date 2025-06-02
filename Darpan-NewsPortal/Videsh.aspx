<%@ Page Title="International - Panchayat Khabar" Language="C#" MasterPageFile="~/Site1.master" AutoEventWireup="true" CodeBehind="Videsh.aspx.cs" Inherits="Darpan.Videsh" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        /* Existing CSS for .selection-section, .info-results-section, .country-info-item */
        .selection-section {
            background-color: #fff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            margin-bottom: 30px;
            text-align: center;
        }

        .selection-section h2 {
            color: #333;
            font-weight: bold;
            margin-bottom: 25px;
            position: relative;
            display: inline-block;
        }

        .selection-section h2::after {
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

        .info-results-section {
            margin-top: 30px;
            background-color: #f8f9fa;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
        }

        .info-results-section h3 {
            color: #333;
            font-weight: bold;
            margin-bottom: 20px;
            text-align: center;
        }

        .country-info-item {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            border: 1px solid #e0e0e0;
            margin-bottom: 15px;
            text-align: left;
        }
        .country-info-item strong {
            color: #007bff;
        }
        .country-info-item p {
            font-size: 1rem;
            line-height: 1.6;
            color: #444;
        }
        .country-info-item .note {
            font-size: 0.9rem;
            color: #6c757d;
            margin-top: 10px;
            border-top: 1px dashed #eee;
            padding-top: 10px;
        }

        /* New CSS for mode selection buttons */
        .mode-selection-bar {
            background-color: #007bff; /* Blue background */
            padding: 15px 0;
            margin-bottom: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            text-align: center;
        }

        .mode-selection-bar .btn-mode {
            background-color: #ffffff; /* White background for buttons */
            color: #007bff; /* Blue text */
            border: 1px solid #ffffff;
            padding: 10px 25px;
            margin: 0 10px;
            border-radius: 5px;
            font-weight: bold;
            text-decoration: none;
            transition: background-color 0.3s ease, color 0.3s ease;
        }

        .mode-selection-bar .btn-mode:hover,
        .mode-selection-bar .btn-mode.active {
            background-color: #0056b3; /* Darker blue on hover/active */
            color: #ffffff; /* White text on hover/active */
            border-color: #0056b3;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="mode-selection-bar">
                    <asp:LinkButton ID="btnExploreCountries" runat="server" CssClass="btn-mode active" OnClick="btnExploreCountries_Click">Explore Countries</asp:LinkButton>
                    <asp:LinkButton ID="btnGetCountryNews" runat="server" CssClass="btn-mode" OnClick="btnGetCountryNews_Click">Get Country News</asp:LinkButton>
                </div>

                <asp:Panel ID="pnlExploreCountries" runat="server" Visible="true">
                    <div class="selection-section">
                        <h2>Explore International Countries</h2>
                        <div class="form-group">
                            <label for="ddlCountries" class="font-weight-bold mb-2">Select a Country:</label>
                            <asp:DropDownList ID="ddlCountries" runat="server" CssClass="form-control"
                                AutoPostBack="True" OnSelectedIndexChanged="ddlCountries_SelectedIndexChanged">
                                <asp:ListItem Text="-- Select Country --" Value="0"></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>

                    <div class="info-results-section">
                        <h3>Information for <asp:Literal ID="litSelectedCountry" runat="server"></asp:Literal></h3>
                        <hr />

                        <asp:Panel ID="pnlMessage" runat="server" CssClass="alert alert-info text-center" Visible="true">
                            Please select an International Country from the dropdown above.
                        </asp:Panel>

                        <asp:Repeater ID="rptCountryInfo" runat="server">
                            <ItemTemplate>
                                <div class="country-info-item">
                                    <h4><strong>Country:</strong> <%# Eval("CountryName") %></h4>
                                    <p><strong>ID:</strong> <%# Eval("CountryId") %></p>
                                    <p><%# Eval("Info") %></p>
                                    <div class="note">
                                        <em>Note: This content is for presentation purposes only and is not fetched from specific country-related news.</em>
                                    </div>
                                </div>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Panel ID="pnlNoInfoFound" runat="server" Visible='<%# rptCountryInfo.Items.Count == 0 %>'>
                                    <div class="alert alert-warning text-center mt-3">No specific information found for this country yet.</div>
                                </asp:Panel>
                            </FooterTemplate>
                        </asp:Repeater>
                    </div >
                </asp:Panel>

                <asp:Panel ID="pnlGetCountryNews" runat="server" Visible="false">
                    <div class="info-results-section">
                        <h3>News for <asp:Literal ID="litSelectedCountryNews" runat="server"></asp:Literal></h3>
                        <hr />
                        <div class="alert alert-warning text-center mt-3">
                            News content for countries is not yet integrated. This section is under development.
                            Please select a country from the "Explore Countries" section to view placeholder information.
                        </div>
                        </div>
                </asp:Panel>
            </div>
        </div>
    </div>
</asp:Content>