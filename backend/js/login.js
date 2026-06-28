function login() {

    let email = document.getElementById("username").value.trim();
    let password = document.getElementById("password").value;

    // Check if email ends with @thapar.edu
    if (!email.endsWith("@thapar.edu")) {
        alert("Please use your Thapar email address.");
        return;
    }

    // Demo password
    if (password === "admin123") {

        alert("Login Successful!");
        window.location.href = "backend/dashboard.html";

    } else {

        alert("Invalid Password!");

    }
}