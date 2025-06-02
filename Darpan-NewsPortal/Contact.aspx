<%@ Page Title="Contact Us" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="Darpan.Contact" Async="true" %>

<asp:Content ID="ContentHead" ContentPlaceHolderID="head" runat="server">
    <%-- Internal CSS for this page --%>
    <style>
        /* Custom style for the form background */
        .contact-form-bg {
            background-color: #f8f9fa; /* A very light grey Bootstrap color */
            border: 1px solid #e9ecef; /* Subtle border for definition */
        }

        /* Map container for aspect ratio */
        .map-container {
            position: relative;
            padding-bottom: 75%; /* 4:3 Aspect Ratio (adjust as needed, e.g., 56.25% for 16:9) */
            height: 0;
            overflow: hidden;
            border-radius: 8px; /* Match outer card/element rounding */
        }

        .map-container iframe {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            border: 0; /* Remove default iframe border */
        }

        /* Social icons custom styling for hover effects */
        .social-icons a {
            transition: transform 0.2s ease-in-out;
        }

        .social-icons a:hover {
            transform: translateY(-3px); /* Slight lift on hover */
        }

        /* You can add any other page-specific CSS here */
    </style>
</asp:Content>

<asp:Content ID="ContentMain" ContentPlaceHolderID="MainContent" runat="server">
    <%-- Changed my-5 to mt-3 to reduce gap from navbar and provide minimal top margin --%>
    <div class="container mt-3 mb-5"> 
        <div class="row justify-content-center">
            <div class="col-lg-10">
                <div class="card shadow-sm border-0">
                    <div class="card-body p-4 p-md-5">
                        <h2 class="card-title text-center mb-4 text-primary fw-bold">Contact Us</h2>
                        <p class="text-center mb-5 text-muted">We'd love to hear from you! Please fill out the form below or find our contact details.</p>

                        <div class="row">
                            <%-- Form Section --%>
                            <div class="col-md-12">
                                <div class="p-4 rounded contact-form-bg"> <%-- Added contact-form-bg class for light grey background --%>
                                    <h4 class="mb-4 text-secondary">Send Us a Message</h4>
                                    <div class="mb-3">
                                        <label for="txtName" class="form-label">Name <span class="text-danger">*</span></label>
                                        <asp:TextBox ID="txtName" runat="server" CssClass="form-control" Required="true" placeholder="Your Name"></asp:TextBox>
                                    </div>
                                    <div class="mb-3">
                                        <label for="txtEmail" class="form-label">Email <span class="text-danger">*</span></label>
                                        <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" CssClass="form-control" Required="true" placeholder="your.email@example.com"></asp:TextBox>
                                    </div>
                                    <div class="mb-3">
                                        <label for="txtSubject" class="form-label">Subject</label>
                                        <asp:TextBox ID="txtSubject" runat="server" CssClass="form-control" placeholder="Subject of your message"></asp:TextBox>
                                    </div>
                                    <div class="mb-4">
                                        <label for="txtMessage" class="form-label">Message <span class="text-danger">*</span></label>
                                        <asp:TextBox ID="txtMessage" runat="server" TextMode="MultiLine" Rows="6" CssClass="form-control" Required="true" placeholder="Your message"></asp:TextBox>
                                    </div>
                                    <asp:Button ID="btnSubmit" runat="server" Text="Send Message" CssClass="btn btn-primary btn-lg w-100" OnClick="btnSubmit_Click" />

                                    <asp:Literal ID="litMessage" runat="server" EnableViewState="false" />
                                </div>
                            </div>

                            <%-- Contact Details Section - Moved below the form and given its own row/column structure --%>
                            <div class="col-md-12 mt-5"> <%-- Added mt-5 for space between form and this section --%>
                                <div class="row">
                                    <div class="col-md-6 mb-4">
                                        <h4 class="mb-4 text-secondary">Our Office Details</h4>
                                        <div class="d-flex align-items-start mb-3">
                                            <i class="fas fa-map-marker-alt fa-lg text-primary me-3 mt-1"></i>
                                            <div>
                                                <p class="mb-0"><strong>Main Office:</strong> F-32, Adarsh Marg, Sarvodaya Nagar, Lucknow-226016, U.P</p>
                                                <p class="mb-0"><strong>Branch Office:</strong> B-4/91, Vineet Khand, Gomti Nagar, Lucknow-226010, U.P</p>
                                            </div>
                                        </div>
                                        <div class="d-flex align-items-center mb-3">
                                            <i class="fas fa-phone-alt fa-lg text-primary me-3"></i>
                                            <p class="mb-0"><strong>Phone:</strong> <a href="tel:9792531351" class="text-decoration-none text-dark">9792531351</a></p>
                                        </div>
                                        <div class="d-flex align-items-center mb-4">
                                            <i class="fas fa-envelope fa-lg text-primary me-3"></i>
                                            <p class="mb-0"><strong>Email:</strong> <a href="mailto:panchayatkhabar@gmail.com" class="text-decoration-none text-dark">panchayatkhabar@gmail.com</a></p>
                                        </div>
                                        <h4 class="mb-3 text-secondary">Follow Us</h4>
                                        <div class="social-icons">
                                            <a href="#" target="_blank" class="text-decoration-none me-3"><i class="fab fa-facebook-f fa-2x text-primary"></i></a>
                                            <a href="#" target="_blank" class="text-decoration-none me-3"><i class="fab fa-instagram fa-2x text-danger"></i></a>
                                            <a href="#" target="_blank" class="text-decoration-none me-3"><i class="fab fa-youtube fa-2x text-danger"></i></a>
                                            <a href="#" target="_blank" class="text-decoration-none"><i class="fab fa-whatsapp fa-2x text-success"></i></a>
                                        </div>
                                    </div>
                                    <div class="col-md-6 mb-4">
                                        <h4 class="mb-3 text-secondary">Our Location</h4>
                                        <div class="map-container rounded shadow-sm">
                                            <iframe
                                                src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3558.730248496155!2d80.9575024149954!3d26.879796083146433!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x399bfd177b949219%3A0xc07a3c3c7e3f22c8!2sF-32%2C%20Adarsh%20Marg%2C%20Sarvodaya%20Nagar%2C%20Lucknow%2C%20Uttar%20Pradesh%20226016!5e0!3m2!1sen!2sin!4v1678901234567!5m2!1sen!2sin"
                                                width="100%"
                                                height="300"
                                                style="border:0;"
                                                allowfullscreen=""
                                                loading="lazy"
                                                referrerpolicy="no-referrer-when-downgrade">
                                            </iframe>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>