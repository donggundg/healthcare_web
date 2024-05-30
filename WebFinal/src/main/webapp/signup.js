

let isValidFirstName = false;//flag to store whether the firstname is valid or not
let isValidLastName = false;//flag to store whether the lastname is valid or not
let isValidPassword = false;//flag to store whether the password is valid or not
let isValidConfirmPassword = false;//flag to store whether the confirm password is valid or not
let isValidGender = false;//flag to store whether the gender is valid or not
let isValidEmail = false;//flag to store whether the email is valid or not

$(document).ready(function () {
    let users = [];//store the user information
    
    //when i click tab container, remove the active class from all tabs, and add the active class to the clicked tab
    //hide all forms
    //show the correct form based on the clicked tab
    $('.tab').on('click', function() {
        $('.tab').removeClass('active');
        $(this).addClass('active');
        
        $('#loginForm, #signupForm').hide();
        
        if($(this).is('#loginTab')) {
            $('#loginForm').show();
        } else {
            $('#signupForm').show();
        }
    });

    //function to hide the login content
    function hideLoginContent() {
        $('#loginForm').hide();
        $('#signupForm').hide();
        $('.success').hide();
        $('.tabs').hide();
    }

    //when i click login tab, hide all error messages, and checkmarks, and initalize the inputs, and css
    //fadout the signupForm and fade in the login form
    $('#loginTab').click(function () {
        // Hide all error messages
        $('.errorFirst').hide();
        $('.errorLast').hide();
        $('.errorPass').hide();
        $('.errorConfirm').hide();
        $('.errorGender').hide();
        $('.errorEmail').hide();
        $('.errorLoginEmail').hide();
        $('.errorLoginPassword').hide();
        $('.success').fadeOut(1);
        $('#checkMarkFirstName, #checkMarkLastName,#checkMarkEmail, #checkMarkPassword, #checkMarkConfirmPassword, #checkMarkGender').text('');
        $('#email').val('');
        $('#password').val('');
        $('.loginState').text('Enter user name and password:').css('color', 'white');
        // Set margin-top for login-container
        $('.container').css('margin-top', '-228px');

        // Move signup-container inside login-container
        $('.signup-container').appendTo('.login-container');

        // Reset all input fields
        $('input[name="signupGender"]').prop('checked', false);
        $('#signupEmail').val('').css('border-color', 'white');
        $('#signupName').val('').css('border-color', 'white');
        $('#signupLast').val('').css('border-color', 'white');
        $('#signupPassword').val('').css('border-color', 'white');
        $('#signupConfirm').val('').css('border-color', 'white');

        $('.login-container').animate({ height: '300px' }, 0, function () {
            $('#signupForm').fadeOut(100, function () {
                $('#loginForm').fadeIn(100);
            });
        });
    });

    //when i click sign up tab, initalize all css from the login-container, and fade in, fade out the forms
    $('#signupTab').click(function () {
        $('.container').css('margin-top', '20px');
        $('#checkMarkLoginEmail, #checkMarkLoginPassword').text('');
        $('#email').val('').css('border-color', 'white');
        $('#password').val('').css('border-color', 'white');
        $('.errorLoginEmail').hide();
        $('.errorLoginPassword').hide();
        //animation
        $('.login-container').animate({ height: '560px' }, 0, function () {
            $('#loginForm').fadeOut(100, function () {
                $('#signupForm').fadeIn(100);
            });
        });
    });

    //Code that causes only one of two radio buttons to be clicked
    $('input[type="radio"]').click(function () {
        if ($(this).attr('id') === 'signupMale') {
          $('#signupFemale').prop('checked', false);
        } else if ($(this).attr('id') === 'signupFemale') {
          $('#signupMale').prop('checked', false);
        }
      });

    //function that judges the email input if the input is wrong or right, if it is right add check mark, if it is not, design error css
     function validateEmailInput() {
        var emailInput = $('#signupEmail');
        var email = emailInput.val();
        var emailRegex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/;

        if (email.trim() === "") {
            emailInput.css('border-color','red');
            return 'Please enter your email!';
        } else if (!emailRegex.test(email)) {
            emailInput.css('border-color','red');
            return 'Please enter a valid email address!';
        } else {
            emailInput.css('border-color','white');
            return '';
        }
    }

    //function that judges the first name input if the input is wrong or right, if it is right add check mark, if it is not, design error css
    function validateFirstNameInput() {
    var firstNameInput = $('#signupName');
    var firstName = firstNameInput.val();
    
    if (firstName.trim() === "") {
        firstNameInput.css('border-color', 'red');
        return 'You have to fill in the first name!';
    } else {
        firstNameInput.css('border-color', 'white');
        return '';
    }
}
    
    //function that judges the last name input if the input is wrong or right, if it is right add check mark, if it is not, design error css
    function validateLastNameInput() {
    var lastNameInput = $('#signupLast');
    var lastName = lastNameInput.val();
    var startsWithCapital = /^[A-Z]/.test(lastName);
    var containsNumber = /\d/.test(lastName);

    if (lastName === "") {
        lastNameInput.css('border-color','red');
        return 'You have to fill in the last name!';
    }  else {
        lastNameInput.css('border-color', 'white');
        return '';
    }
}
    
    //function that judges the password input if the input is wrong or right, if it is right add check mark, if it is not, design error css
   function validatePasswordInput() {
    var passwordInput = $('#signupPassword');
    var password = passwordInput.val();
    var isValidPassword = /^(?=.*[!@#$%^&*(),.?":{}|<>])[A-Za-z\d!@#$%^&*(),.?":{}|<>]{7,}$/.test(password);

    if (password === "") {
        passwordInput.css('border-color','red');
        return 'You have to fill in the password!';
    } else if (!isValidPassword) {
        passwordInput.css('border-color','red');
        return 'Password must be at least 7 characters including special characters!';
    } else {
        passwordInput.css('border-color','white');
        return '';
    }
}
    //function that judges the confirm password input if the input is wrong or right, if it is right add check mark, if it is not, design error css
    function validateConfirmPasswordInput() {
    var confirmPasswordInput = $('#signupConfirm');
    var confirmPassword = confirmPasswordInput.val();
    var password = $('#signupPassword').val();

    if (confirmPassword === "") {
        confirmPasswordInput.css('border-color','red');
        return 'You have to confirm your password!';
    } else if (confirmPassword !== password) {
        confirmPasswordInput.css('border-color','red');
        return 'Passwords do not match!';
    } else {
        confirmPasswordInput.css('border-color','white');
        return '';
    }
}
    
    //function that judges the gender input if the input is wrong or right, if it is right add check mark, if it is not, design error css
    function validateGenderInput() {
    var genderSelected = $('input[name="gender"]:checked').length > 0;

    if (!genderSelected) {
        return 'You have to select your gender!';
    } else {
        return '';
    }
}


    //function that judges the email input in the login side, if the input is wrong or right, if it is right add check mark, if it is not, design error css
    function validateLoginEmail() {
        var emailInput = $('#email');
        var email = emailInput.val();
        var emailRegex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/;
    
        if (!emailRegex.test(email)) {
            emailInput.css('border-color', 'red');
            emailInput.addClass('error');
            $('#loginEmailError').text('Please enter a valid email address!');
            $('.errorLoginEmail').show();
            emailInput.next('.check-mark').text('');
            $('#errorLoginEmail').show();
            return false;
        } else {
            validateLoginPassword();
            emailInput.css('border-color', 'white');
            emailInput.removeClass('error');
            $('#loginEmailError').text('');
            $('.errorLoginEmail').hide();
            emailInput.next('.check-mark').text('✅');
            $('#errorLoginEmail').hide();
            return true;
        }
    }
    //function that judges the password input in the login side, if the input is wrong or right, if it is right add check mark, if it is not, design error css
    function validateLoginPassword() {
        var passwordInput = $('#password');
        var password = passwordInput.val();
    
        if (password === '') {
            passwordInput.css('border-color', 'red');
            passwordInput.addClass('error');
            $('#loginPasswordError').text('Please enter your password!');
            $('.errorLoginPassword').show();
            passwordInput.next('.check-mark').text('');
            $('#errorLoginPassword').show();
            return false;
        } else {
            passwordInput.css('border-color', 'white');
            passwordInput.removeClass('error');
            $('#loginPasswordError').text('');
            $('.errorLoginPassword').hide();
            return true;
        }
    }
    
    // First Name Validation
    $('#signupName').on('input', function () {
        validateFirstNameInput();
    });
    
    // Last Name Validation
    $('#signupLast').on('input', function () {
        validateLastNameInput();
    });
    
    // Password Validation
    $('#signupPassword').on('input', function () {
    validatePasswordInput();
});
    
    // Confirm Password Validation
    $('#signupConfirm').on('input', function () {
        validateConfirmPasswordInput();
    });
    
    // Gender Validation
    $('input[type=radio][name=signupGender]').change(function () {
        validateGenderInput();
    });

// Email Validation
$('#signupEmail').on('input', function () {
    validateEmailInput();
});

// Password Validation for login side
$('#password').on('input', function () {
    validateLoginPassword();
});


// Email Validation for login side
$('#email').on('input', function (){
    validateLoginEmail();
});


//if signup-button clicked, check if the inputs are valid, and if it is, store the information in to the user variable and show the success message
$('.signup-button').click(function () {
    var email = $('#signupEmail').val();
    var errorMessages = [];

    $.ajax({
        url: '/path/to/check-email',
        method: 'POST',
        data: { email: email },
        success: function(response) {
            if (response.exists) {
                errorMessages.push('The email already exists!');
            } else {
                var firstNameError = validateFirstNameInput();
                var lastNameError = validateLastNameInput();
                var genderError = validateGenderInput();
                var emailError = validateEmailInput();
                var passwordError = validatePasswordInput();
                var confirmPasswordError = validateConfirmPasswordInput();

                if (firstNameError) errorMessages.push(firstNameError);
                if (lastNameError) errorMessages.push(lastNameError);
                if (genderError) errorMessages.push(genderError);
                if (emailError) errorMessages.push(emailError);
                if (passwordError) errorMessages.push(passwordError);
                if (confirmPasswordError) errorMessages.push(confirmPasswordError);
            }

            if (errorMessages.length > 0) {
                alert(errorMessages.join('\n'));
            }
        },
        error: function(xhr, status, error) {
    console.log('Error checking email: ' + error);
    console.log('HTTP status: ' + status);
    console.log('XHR object: ', xhr);
}
    });
});


});

