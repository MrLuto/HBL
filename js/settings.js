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

if (loggedIn == false){
    window.location.href = "login.html";
}