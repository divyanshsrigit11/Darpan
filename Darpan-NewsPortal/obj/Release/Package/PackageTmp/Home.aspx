<%@ Page Title="Home" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="Darpan.Home" %>

<asp:Content ID="ContentHead" ContentPlaceHolderID="head" runat="server">
    <%-- Any specific head content for your Home page, e.g., <meta> tags, specific CSS --%>
</asp:Content>

<asp:Content ID="ContentMain" ContentPlaceHolderID="MainContent" runat="server">
    <%-- All the content that was originally in Site1.Master's body (excluding header/footer, which are in the Master Page) --%>
    <div class="row">
        <div class="col-md-7 featured-section">
            <img src="img/home.png" alt="Featured News Banner" class="img-fluid featured-banner" />
            <div class="editorial-section mt-4">
                <h4>Editorial</h4>
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <img src="img/home.png" alt="Editorial 1" class="img-fluid" />
                        <p class="mt-2">This is the title of the editorial article.</p>
                        <a href="#" class="read-more">Read More</a>
                    </div>
                    <div class="col-md-6 mb-3">
                        <img src="img/gallery.png" alt="Editorial 2" class="img-fluid" />
                        <p class="mt-2">This is another important editorial.</p>
                        <a href="#" class="read-more">Read More</a>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-5 news-list-section">
            <h4 class="section-title">Breaking News</h4>
            <div class="news-scroll-container">
                <ul class="list-group news-list">
                    <li class="list-group-item">
                        <a href="#">
                            <div class="news-item-content">
                                <span class="news-icon">📰</span> <strong>Breaking News:</strong> Prime Minister inaugurated new scheme today.
                            </div>
                            <span class="news-read-more">Read More</span>
                        </a>
                    </li>
                    <li class="list-group-item">
                        <a href="#">
                            <div class="news-item-content">
                                <span class="news-icon">☔</span> <strong>Uttar Pradesh</strong> warning of heavy rain.
                            </div>
                            <span class="news-read-more">Read More</span>
                        </a>
                    </li>
                    <li class="list-group-item">
                        <a href="#">
                            <div class="news-item-content">
                                <span class="news-icon">🚂</span> <strong>Railways</strong> released new timetable.
                            </div>
                            <span class="news-read-more">Read More</span>
                        </a>
                    </li>
                    <li class="list-group-item">
                        <a href="#">
                            <div class="news-item-content">
                                <span class="news-icon">📚</span> <strong>Education Department</strong> announced 12th exam dates.
                            </div>
                            <span class="news-read-more">Read More</span>
                        </a>
                    </li>
                    <li class="list-group-item">
                        <a href="#">
                            <div class="news-item-content">
                                <span class="news-icon">🏏</span> <strong>Cricket:</strong> India defeated Pakistan.
                            </div>
                            <span class="news-read-more">Read More</span>
                        </a>
                    </li>
                    <li class="list-group-item">
                        <a href="#">
                            <div class="news-item-content">
                                <span class="news-icon">🏥</span> <strong>Health Sector</strong> new initiative launched.
                            </div>
                            <span class="news-read-more">Read More</span>
                        </a>
                    </li>
                    <li class="list-group-item">
                        <a href="#">
                            <div class="news-item-content">
                                <span class="news-icon">📊</span> <strong>Economy:</strong> Signs of improvement.
                            </div>
                            <span class="news-read-more">Read More</span>
                        </a>
                    </li>
                    <li class="list-group-item">
                        <a href="#">
                            <div class="news-item-content">
                                <span class="news-icon">🚓</span> <strong>Crime News:</strong> Major arrest in the city.
                            </div>
                            <span class="news-read-more">Read More</span>
                        </a>
                    </li>
                    <li class="list-group-item">
                        <a href="#">
                            <div class="news-item-content">
                                <span class="news-icon">🌾</span> <strong>Agriculture Department</strong> announced new subsidy.
                            </div>
                            <span class="news-read-more">Read More</span>
                        </a>
                    </li>
                    <li class="list-group-item">
                        <a href="#">
                            <div class="news-item-content">
                                <span class="news-icon">🗳️</span> <strong>Election</strong> results to be declared this evening.
                            </div>
                            <span class="news-read-more">Read More</span>
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </div>
    
    <div class="latest-news-section mt-4"> <h4 class="section-title">Latest News</h4>
        <div class="horizontal-scroll-container">
            <div class="horizontal-scroll-content">
                <div class="news-card">
                    <img src="Images/news1.png" alt="News 1" class="img-fluid news-card-img" />
                    <div class="news-card-body">
                        <h6 class="news-card-title">Major Announcement: Prime Minister inaugurated new scheme today.</h6>
                        <a href="#" class="read-more">Read More</a>
                    </div>
                </div>
                <div class="news-card">
                    <img src="Images/news2.png" alt="News 2" class="img-fluid news-card-img" />
                    <div class="news-card-body">
                        <h6 class="news-card-title">Weather Alert: Heavy rain warning for Uttar Pradesh.</h6>
                        <a href="#" class="read-more">Read More</a>
                    </div>
                </div>
                <div class="news-card">
                    <img src="Images/news3.png" alt="News 3" class="img-fluid news-card-img" />
                    <div class="news-card-body">
                        <h6 class="news-card-title">Railways released new timetable for express trains.</h6>
                        <a href="#" class="read-more">Read More</a>
                    </div>
                </div>
                <div class="news-card">
                    <img src="Images/news4.png" alt="News 4" class="img-fluid news-card-img" />
                    <div class="news-card-body">
                        <h6 class="news-card-title">Education Dept. announced 12th board exam dates.</h6>
                        <a href="#" class="read-more">Read More</a>
                    </div>
                </div>
                <div class="news-card">
                    <img src="Images/news5.png" alt="News 5" class="img-fluid news-card-img" />
                    <div class="news-card-body">
                        <h6 class="news-card-title">Cricket: India defeated Pakistan in thrilling match.</h6>
                        <a href="#" class="read-more">Read More</a>
                    </div>
                </div>
                <div class="news-card">
                    <img src="Images/news6.png" alt="News 6" class="img-fluid news-card-img" />
                    <div class="news-card-body">
                        <h6 class="news-card-title">Health Sector: New initiative launched for public welfare.</h6>
                        <a href="#" class="read-more">Read More</a>
                    </div>
                </div>
                <div class="news-card">
                    <img src="Images/news7.png" alt="News 7" class="img-fluid news-card-img" />
                    <div class="news-card-body">
                        <h6 class="news-card-title">Economy: Signs of improvement observed in recent reports.</h6>
                        <a href="#" class="read-more">Read More</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    </div>
    </asp:Content>
