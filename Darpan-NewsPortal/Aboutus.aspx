<%@ Page Title="About Us - Panchayat Khabar" Language="C#" MasterPageFile="~/Site1.master" AutoEventWireup="true" CodeBehind="AboutUs.aspx.cs" Inherits="Darpan.AboutUs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <%-- Page-specific CSS for About Us page --%>
    <style>
        .about-section {
            background-color: #fff;
            padding: 40px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            margin-bottom: 30px;
            text-align: center; /* Center the title and image */
        }

        .about-section h2 {
            color: #333;
            font-weight: bold;
            margin-bottom: 25px;
            position: relative;
            display: inline-block; /* To allow underline effect */
        }

        .about-section h2::after {
            content: '';
            display: block;
            width: 80%; /* Adjust width of the underline */
            height: 3px;
            background-color: #007bff; /* Primary color underline */
            margin: 10px auto 0; /* Center the underline */
        }

        .about-image {
            max-width: 80%; /* Adjust as needed */
            height: auto;
            border-radius: 8px;
            margin-bottom: 30px;
            border: 3px solid #ddd; /* A subtle border */
        }

        .about-content p {
            font-size: 1.05rem;
            line-height: 1.8;
            color: #555;
            margin-bottom: 20px;
            text-align: justify;
        }

        .about-content ul {
            list-style-type: none; /* Remove default bullet points */
            padding-left: 0;
        }

        .about-content ul li {
            background: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="%23007bff" class="bi bi-check-circle-fill" viewBox="0 0 16 16"><path d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0zm-3.97-3.03a.75.75 0 0 0-1.08.022L7.477 9.417 5.384 7.323a.75.75 0 0 0-1.06 1.06L6.97 11.03a.75.75 0 0 0 1.079-.02l3.992-4.99a.75.75 0 0 0-.01-1.05z"/></svg>') no-repeat left center;
            background-size: 16px 16px;
            padding-left: 25px; /* Space for the icon */
            margin-bottom: 10px;
            color: #444;
            text-align: left; /* Align list items to left */
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-10">
                <div class="about-section">
                    <h2>About Panchayat Khabar</h2>
                    <img src="img/logo.jpeg" alt="Panchayat Khabar Logo" class="img-fluid about-image" />
                    <div class="about-content">
                        <p>
                            <strong>Panchayat Khabar</strong> is a leading news portal dedicated to bringing you comprehensive and unbiased news from the grassroots level. Our mission is to empower rural communities by providing timely, accurate, and relevant information that impacts their daily lives, governance, and development. We believe in the power of local journalism to foster transparency, accountability, and participation in the democratic process.
                        </p>
                        <p>
                            Founded with a vision to bridge the information gap in rural areas, Panchayat Khabar focuses on covering stories that often go unnoticed by mainstream media. From local government initiatives and public welfare schemes to community achievements, challenges, and cultural events, we strive to present a holistic picture of life in India's villages and towns.
                        </p>
                        <h3>Our Vision</h3>
                        <ul>
                            <li>To be the most trusted source of local news and information for rural India.</li>
                            <li>To empower citizens with knowledge to make informed decisions and participate effectively in local governance.</li>
                            <li>To promote positive change and highlight developmental success stories at the grassroots.</li>
                        </ul>
                        <h3>Our Values</h3>
                        <p>
                            We are committed to journalistic integrity, accuracy, and fairness. Our team of dedicated reporters works tirelessly to bring you news that matters, respecting diverse perspectives and upholding the highest ethical standards. We are passionate about serving the community and contributing to a well-informed society.
                        </p>
                        <p>
                            Thank you for visiting Panchayat Khabar. We hope our platform serves as a valuable resource for you to stay connected and informed about the vibrant life and progress in your local communities.
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
