window.location.href = "index.html";

let cookies = document.cookie;
let cookies_splitted = cookies.split(";");
var loggedIn = false;
var email = "";
cookies_splitted.forEach(cookie => {
    if (cookie == "loggedIn=true"){
        loggedIn = true;
    }else if(cookie.startsWith("user=")){
        email = cookie.split("=")[1];
    }
});

//if (loggedIn == false){
//    window.location.href = "login.html";
//}

let url = "http://162.55.245.188:26133/hbl/getinfo?uid=" + email;
let request = new XMLHttpRequest();
request.open("GET", url, false);
request.send(null);
let response = request.responseText;
console.log(response);
//document.getElementById("firstname").setAttribute('value','tomatensalamie');
//document.getElementById("lastname").setAttribute('value','tomatensalamie');
//document.getElementById("email").setAttribute('value','tomatensalamie');
//document.getElementById("iban").setAttribute('value','tomatensalamie');

function logout(){
    document.cookie = "loggedIn=false; expires=Thu, 18 Dec 2028 12:00:00 UTC; path=/;";
    window.location.href = "login.html";
}