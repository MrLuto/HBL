let cookies = document.cookie;
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
    let username = document.getElementById("username").value;
    let password = document.getElementById("password").value;
    let url = "http://162.55.245.188:26133/hbl/login?username=" + username + "&password=" + password;
    let request = new XMLHttpRequest();
    request.open("GET", url, false);
    request.send(null);
    let response = request.responseText;
    if (response == "true"){
        document.cookie = "loggedIn=true; expires=Thu, 18 Dec 2028 12:00:00 UTC; path=/;";
        window.location.href = "settings.html";
    } else {
        document.cookie = "loggedIn=false; expires=Thu, 18 Dec 2028 12:00:00 UTC; path=/;";
        window.location.href = "login.html";
    }
}