<%@ Page Title="Panchayat Search - Panchayat Khabar" Language="C#" MasterPageFile="~/Site1.master" AutoEventWireup="true" CodeBehind="Panchayat.aspx.cs" Inherits="Darpan.Panchayat" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .search-section {
            background-color: #fff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            margin-bottom: 30px;
        }

        .search-section h2 {
            color: #333;
            font-weight: bold;
            margin-bottom: 25px;
            text-align: center;
            position: relative;
            display: inline-block;
        }
        .search-section h2::after {
            content: '';
            display: block;
            width: 80%;
            height: 3px;
            background-color: #007bff;
            margin: 10px auto 0;
        }

        .search-box-group {
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 20px;
            background-color: #f8f9fa;
        }
        .search-box-group label {
            font-weight: bold;
            margin-bottom: 10px;
            display: block;
        }
        .search-box-group .form-control {
            max-width: 250px; /* Keep input field reasonable size */
            display: inline-block;
            margin-right: 10px;
        }
        .search-box-group .btn {
            vertical-align: top; /* Align button with input */
        }
        .search-notes {
            font-size: 0.85rem;
            color: #6c757d;
            margin-top: 10px;
        }

        .results-section {
            margin-top: 30px;
            background-color: #f8f9fa;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
        }

        .results-section h3 {
            color: #333;
            font-weight: bold;
            margin-bottom: 20px;
            text-align: center;
        }

        .panchayat-list-item {
            background-color: #fff;
            padding: 15px 20px;
            border-radius: 5px;
            border: 1px solid #e0e0e0;
            margin-bottom: 10px;
            text-align: left;
            font-size: 1.1rem;
            color: #333;
            display: flex;
            flex-direction: column; /* Stack info vertically */
        }
        .panchayat-list-item strong {
            color: #007bff;
        }
        .panchayat-list-item span {
            font-size: 0.95rem;
            color: #555;
            margin-top: 5px;
        }
        .panchayat-list-item i {
            margin-right: 8px;
            color: #28a745; /* Green check icon */
        }
    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-10">
                <div class="search-section">
                    <h2>Find Gram Panchayats</h2>
                    <div class="row justify-content-center">
                        <div class="col-md-6">
                            <div class="search-box-group">
                                <label for="txtBlockId">Search by Block ID:</label>
                                <asp:TextBox ID="txtBlockId" runat="server" CssClass="form-control" Placeholder="e.g., 385"></asp:TextBox>
                                <asp:Button ID="btnSearchBlock" runat="server" Text="Search Block" CssClass="btn btn-primary mt-2 mt-md-0" OnClick="btnSearchBlock_Click" />
                                <div class="search-notes">
                                    <i class="fas fa-info-circle"></i> Use Block IDs from 380 to 396.
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="search-box-group">
                                <label for="txtGramPanchayatId">Search by Gram Panchayat ID:</label>
                                <asp:TextBox ID="txtGramPanchayatId" runat="server" CssClass="form-control" Placeholder="e.g., 50"></asp:TextBox>
                                <asp:Button ID="btnSearchGramPanchayat" runat="server" Text="Search Panchayat" CssClass="btn btn-info mt-2 mt-md-0" OnClick="btnSearchGramPanchayat_Click" />
                                <div class="search-notes">
                                    <i class="fas fa-info-circle"></i> Use Gram Panchayat IDs from 1 to 1000.
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="results-section">
                    <h3>Search Results</h3>
                    <hr />

                    <asp:Panel ID="pnlMessage" runat="server" CssClass="alert alert-info text-center" Visible="true">
                        Enter a Block ID or Gram Panchayat ID to search.
                    </asp:Panel>

                    <asp:Repeater ID="rptPanchayats" runat="server">
                        <ItemTemplate>
                            <div class="panchayat-list-item">
                                <div><i class="fas fa-code-branch"></i> Gram Panchayat Name: <strong><%# Eval("GramPanchayatName") %></strong></div>
                                <span><i class="fas fa-hashtag"></i> Gram Panchayat ID: <%# Eval("GramPanchayatID") %></span>
                                <span><i class="fas fa-cube"></i> Block ID: <%# Eval("BlockID") %></span>
                                <%-- You can add CreatedDate or isActive if desired --%>
                                <%-- <span>Created On: <%# Eval("CreatedDate", "{0:dd MMM yyyy}") %></span> --%>
                                <%-- <span>Active: <%# (bool)Eval("isActive") ? "Yes" : "No" %></span> --%>
                            </div>
                        </ItemTemplate>
                        <FooterTemplate>
                            <asp:Panel ID="pnlNoResultsFound" runat="server" Visible='<%# rptPanchayats.Items.Count == 0 %>'>
                                <div class="alert alert-warning text-center mt-3">No Gram Panchayats found for your search criteria.</div>
                            </asp:Panel>
                        </FooterTemplate>
                    </asp:Repeater>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
