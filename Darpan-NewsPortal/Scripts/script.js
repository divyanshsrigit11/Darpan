// Scripts/script.js

// Live Clock Functionality
function updateClock() {
    const now = new Date();
    // Format options for a more standard Indian time format (e.g., 11:30:45 PM)
    const timeOptions = { hour: '2-digit', minute: '2-digit', second: '2-digit', hour12: true };
    const dateOptions = { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' };

    const liveTimeElement = document.getElementById('liveTime');
    if (liveTimeElement) {
        liveTimeElement.innerText = now.toLocaleTimeString('en-IN', timeOptions) + ' | ' + now.toLocaleDateString('en-IN', dateOptions);
    }
}

// Initial call and set interval for updates
document.addEventListener('DOMContentLoaded', () => {
    updateClock();
    setInterval(updateClock, 1000); // Update every second
});

// Optional: Lightbox Initialization (if using ekko-lightbox)
/*
$(document).on('click', '[data-toggle="lightbox"]', function(event) {
    event.preventDefault();
    $(this).ekkoLightbox({
        alwaysShowClose: true
    });
});
*/