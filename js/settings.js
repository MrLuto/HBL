let cookies = document.cookie;
let cookies_splitted = cookies.split(";");
var loggedIn = false;
cookies_splitted.forEach(cookie => {
    if (cookie == "loggedIn=true"){
        loggedIn = true;
    }else if(cookie.startsWith("user=")){
        var email = cookie.split("=")[1]
        document.getElementById("email").value = email;
    }
});

if (loggedIn == false){
    window.location.href = "login.html";
}

let url = "http://162.55.245.188:26133/hbl/getinfo?uid=" + email;
let request = new XMLHttpRequest();
request.open("GET", url, false);
request.send(null);
let response = request.responseText;
console.log(response);

function logout(){
    document.cookie = "loggedIn=false; expires=Thu, 18 Dec 2028 12:00:00 UTC; path=/;";
    window.location.href = "login.html";
}