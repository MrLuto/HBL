let cookies = document.cookie;
let cookies_splitted = cookies.split(";");
var loggedIn = false;
cookies_splitted.forEach(cookie => {
    if (cookie == "loggedIn=true"){
        loggedIn = true;
    }else if(cookie.startsWith("user=")){
        var email = cookie.split("=")[1]
    }
});

if (loggedIn == false){
    window.location.href = "login.html";
}

function logout(){
    document.cookie = "loggedIn=false; expires=Thu, 18 Dec 2028 12:00:00 UTC; path=/;";
    window.location.href = "login.html";
}