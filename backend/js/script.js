console.log("Resource Booking System Loaded");

function login() {

    const email = document.getElementById("username").value.trim().toLowerCase();
    const password = document.getElementById("password").value;

    // Check email
    if (!email.endsWith("@thapar.edu")) {
        alert("Only @thapar.edu email addresses are allowed.");
        return;
    }

    // Check password length
    if (password.length < 8) {
        alert("Password must be at least 8 characters long.");
        return;
    }

    // Save login status
    sessionStorage.setItem("loggedIn", "true");

    alert("Login Successful!");

    // Redirect to dashboard
    window.location.href = "dashboard.html";
}