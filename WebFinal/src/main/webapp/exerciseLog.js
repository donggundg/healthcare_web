//function to re size the mobile and desktop version
 function updateInputStatus() {
        const isMobile = window.innerWidth <= 600;
        document.querySelectorAll('.exercise-table-desktop input').forEach(input => {
            input.disabled = isMobile;
        });
        document.querySelectorAll('.exercise-table-mobile input').forEach(input => {
            input.disabled = !isMobile;
        });
    }
    
//function for log out
function logoutUser() {
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


    // Run on load and on resize
    window.addEventListener('load', updateInputStatus);
    window.addEventListener('resize', updateInputStatus);