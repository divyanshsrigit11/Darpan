<%@ Page Title="Editorial - Panchayat Khabar" Language="C#" MasterPageFile="~/Site1.master" AutoEventWireup="true" CodeBehind="Editorial.aspx.cs" Inherits="Darpan.Editorial" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .editorial-article-item {
            background-color: #fff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            margin-bottom: 30px;
        }

        .editorial-article-item h2 {
            color: #333;
            font-weight: bold;
            margin-bottom: 15px;
            text-align: left; /* Align article titles left */
        }

        .editorial-article-item .article-meta {
            font-size: 0.9rem;
            color: #777;
            margin-bottom: 20px;
            text-align: left;
        }

        .editorial-article-item .article-meta .author {
            font-weight: bold;
            color: #007bff;
        }

        .editorial-article-item .article-image {
            width: 100%;
            height: auto;
            border-radius: 8px;
            margin-bottom: 25px;
        }

        .editorial-article-item .article-content p {
            font-size: 1.1rem;
            line-height: 1.8;
            color: #555;
            margin-bottom: 15px;
            text-align: justify; /* Justify text for a newspaper-like feel */
        }

        /* Video Gallery styles (keep as is from previous step) */
        .video-gallery {
            background-color: #f8f9fa; /* Light background for the gallery section */
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
            margin-top: 30px;
        }

        .video-gallery h2 {
            color: #333;
            font-weight: bold;
            margin-bottom: 25px;
            text-align: center;
            border-bottom: 2px solid #007bff; /* A simple underline effect */
            padding-bottom: 10px;
        }

        .video-item {
            margin-bottom: 20px; /* Spacing between video embeds */
        }

        /* Responsive YouTube embeds (keep as is) */
        .embed-responsive {
            position: relative;
            display: block;
            width: 100%;
            padding: 0;
            overflow: hidden;
        }

        .embed-responsive::before {
            content: "";
            display: block;
            padding-top: 56.25%; /* 16:9 aspect ratio */
        }

        .embed-responsive iframe,
        .embed-responsive embed,
        .embed-responsive object {
            position: absolute;
            top: 0;
            bottom: 0;
            left: 0;
            width: 100%;
            height: 100%;
            border: 0;
        }

        /* Pagination styles */
        .pagination-container {
            margin-top: 30px;
            text-align: center;
        }
        .pagination-container .pagination {
            display: inline-flex;
            padding-left: 0;
            list-style: none;
            border-radius: .25rem;
        }
        .pagination-container .page-item {
            margin: 0 2px;
        }
        .pagination-container .page-link {
            position: relative;
            display: block;
            padding: .5rem .75rem;
            margin-left: -1px;
            line-height: 1.25;
            color: #007bff;
            background-color: #fff;
            border: 1px solid #dee2e6;
            border-radius: .25rem;
            text-decoration: none;
        }
        .pagination-container .page-item.active .page-link {
            z-index: 3;
            color: #fff;
            background-color: #007bff;
            border-color: #007bff;
        }
        .pagination-container .page-item.disabled .page-link {
            color: #6c757d;
            pointer-events: none;
            background-color: #fff;
            border-color: #dee2e6;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-10">

                <asp:Repeater ID="rptNewsArticles" runat="server">
                    <ItemTemplate>
                        <div class="editorial-article-item">
                            <h2><%# Eval("Title") %></h2>
                            <div class="article-meta">
                                By <span class="author"><%# Eval("author_editorid") %></span> on <%# Eval("CreatedOn", "{0:dd MMM yyyy}") %>
                            </div>
                            <asp:Image ID="imgArticle" runat="server" CssClass="img-fluid article-image"
                                ImageUrl='<%# GetImageUrl(Eval("ImagePath"), Eval("ThumbPath")) %>' />
                            <div class="article-content">
                                <p><%# Eval("Discription") %></p>
                                <%-- If you have a separate full content column, use that instead of Discription --%>
                            </div>
                            <hr /> <%-- Separator between articles --%>
                        </div>
                    </ItemTemplate>
                    <SeparatorTemplate>
                        <div class="my-4"></div> <%-- Additional space between articles --%>
                    </SeparatorTemplate>
                    <FooterTemplate>
                        <%-- Message if no articles are found --%>
                        <asp:Panel ID="pnlNoArticles" runat="server" Visible='<%# rptNewsArticles.Items.Count == 0 %>'>
                            <div class="alert alert-info text-center">No editorial articles found for this category.</div>
                        </asp:Panel>
                    </FooterTemplate>
                </asp:Repeater>

                <div class="video-gallery">
                    <h2>VIDEO GALLERY - Latest News & Editorials</h2>
                    <div class="row">
                        <div class="col-md-6 video-item">
                            <div class="embed-responsive embed-responsive-16by9">
                                <iframe class="embed-responsive-item" src="https://m.youtube.com/shorts/EdxoiOSVYVE7" allowfullscreen></iframe>
                            </div>
                            <h5 class="mt-2 text-center">NDTV: Latest Top News Headlines</h5>
                        </div>
                        <div class="col-md-6 video-item">
                            <div class="embed-responsive embed-responsive-16by9">
                                <iframe class="embed-responsive-item" src="https://m.youtube.com/shorts/EdxoiOSVYVE8" allowfullscreen></iframe>
                            </div>
                            <h5 class="mt-2 text-center">ABP News: India's Big Stories</h5>
                        </div>
                        <div class="col-md-6 video-item">
                            <div class="embed-responsive embed-responsive-16by9">
                                <iframe class="embed-responsive-item" src="https://m.youtube.com/shorts/EdxoiOSVYVE9" allowfullscreen></iframe>
                            </div>
                            <h5 class="mt-2 text-center">India Today: Breaking National News</h5>
                        </div>
                        <div class="col-md-6 video-item">
                            <div class="embed-responsive embed-responsive-16by9">
                                <iframe class="embed-responsive-item" src="https://www.youtube.com/watch?v=zX6NA4Bw1mo0" allowfullscreen></iframe>
                            </div>
                            <h5 class="mt-2 text-center">Aaj Tak: Samachar Analysis</h5>
                        </div>
                        </div>
                </div>

                <div class="pagination-container">
                    <nav aria-label="Page navigation">
                        <ul class="pagination" id="paginationList" runat="server">
                            <%-- Pagination links will be dynamically generated here --%>
                        </ul>
                    </nav>
                </div>

            </div>
        </div>
    </div>
</asp:Content>