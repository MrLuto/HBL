let cookies = document.cookie;
// check if the user is logged in by checking if the cookie is set
// if the cookie is not set, redirect to login page
// split cookies into an array then check with an foreach loop if the cookie is set
// if the cookie is set, set the variable to true
// if the cookie is not set, set the variable to false
// if the variable is false, redirect to login page
let cookies_splitted = cookies.split(";");
var loggedIn = false;
cookies_splitted.forEach(cookie => {
    if (cookie == "loggedIn=true"){
        loggedIn = true;
    }
});

if (loggedIn == true){
    window.location.href = "settings.html";
}

function login(){
    // get the username and password from the input fields
    let username = document.getElementById("username").value;
    let password = document.getElementById("password").value;
    // check if the username and password are correct
    // if the username and password are correct, set the cookie to true
    // if the username and password are not correct, set the cookie to false
    if (username == "admin@gmail.com" && password == "admin"){
        document.cookie = "loggedIn=true; expires=Thu, 18 Dec 2028 12:00:00 UTC; path=/;";
        window.location.href = "settings.html";
    } else {
        document.cookie = "loggedIn=false; expires=Thu, 18 Dec 2028 12:00:00 UTC; path=/;";
        window.location.href = "login.html";
    }
}