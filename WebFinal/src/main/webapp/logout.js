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
