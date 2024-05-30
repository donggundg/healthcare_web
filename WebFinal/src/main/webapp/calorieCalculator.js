//function for the mobile and desktop arrangement.
function updateInputStatus() {
    const isMobile = window.innerWidth <= 600;
    document.querySelectorAll('.calorie-table-desktop input').forEach(input => {
        input.disabled = isMobile;
    });
    document.querySelectorAll('.calorie-table-mobile input').forEach(input => {
        input.disabled = !isMobile;
    });
}

//function for log out
function logoutUser() {
    // AJAX request to logout.jsp
    var xhr = new XMLHttpRequest();
    xhr.open("GET", "logout.jsp", true);
    xhr.onreadystatechange = function() {
        if (this.readyState == 4 && this.status == 200) {
            // Redirect to signup.jsp upon successful logout
            window.location.href = "signup.jsp";
        }
    };
    xhr.send();
}

window.addEventListener('load', updateInputStatus);
window.addEventListener('resize', updateInputStatus);

