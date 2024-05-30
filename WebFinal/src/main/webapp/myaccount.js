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

document.addEventListener("DOMContentLoaded", function() {
    // Function to validate password change inputs
    function validatePasswordChange(currentPassword, newPassword, confirmNewPassword) {
        var errors = [];
        var passwordRegex = /^(?=.*[!@&]).{7,}$/; // At least 7 characters including special characters

        if (!currentPassword) {
            errors.push("Please enter your current password.");
        }
        if (!newPassword) {
            errors.push("Please enter your new password.");
        }
        if (!confirmNewPassword) {
            errors.push("Please enter your confirm new password.");
        }
        if (newPassword && newPassword === currentPassword) {
            errors.push("New password should not match current password!");
        }
        if (newPassword && confirmNewPassword && newPassword !== confirmNewPassword) {
            errors.push("New password and confirm password should be same!");
        }
        if (newPassword && !passwordRegex.test(newPassword)) {
            errors.push("Password should be length of 7 consisting !, @, &.");
        }
        return errors;
    }

    // Function to handle password change form submission
    var passwordChangeForm = document.querySelector('.password-change form');
    if (passwordChangeForm) {
        passwordChangeForm.onsubmit = function(e) {
            e.preventDefault();

            var currentPassword = document.querySelector('input[name="currentPassword"]').value;
            var newPassword = document.querySelector('input[name="newPassword"]').value;
            var confirmNewPassword = document.querySelector('input[name="confirmNewPassword"]').value;

            var validationErrors = validatePasswordChange(currentPassword, newPassword, confirmNewPassword);

            if (validationErrors.length > 0) {
                alert(validationErrors.join("\n"));
                return;
            }

            
           var xhr = new XMLHttpRequest();
            xhr.open("POST", "changePassword.jsp", true);
            xhr.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
            xhr.onload = function() {
                if (xhr.status === 200) {
                    // Trim and display the response
                    var responseText = xhr.responseText.trim();
                    var cleanResponse = responseText.replace(/<\/?[^>]+(>|$)/g, ""); // Remove HTML tags
                    alert(cleanResponse);
                } else {
                    alert('Error occurred while changing password.');
                }
            };

            var data = "currentPassword=" + encodeURIComponent(currentPassword) +
                       "&newPassword=" + encodeURIComponent(newPassword) +
                       "&confirmNewPassword=" + encodeURIComponent(confirmNewPassword);
            xhr.send(data);
        };
    }
});
