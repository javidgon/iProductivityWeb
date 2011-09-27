
var http = false;

if(navigator.appName == "Microsoft Internet Explorer") {
    http = new ActiveXObject("Microsoft.XMLHTTP");
} else {
    http = new XMLHttpRequest();
}
function validateEmail(user) {

    http.abort();
    http.open("GET", "validationServlet?email=" + user, true);
    http.onreadystatechange= functionToRunEmail;
    http.send(null);

}

function validatePass(pass) {

    http.abort();
    http.open("GET", "validationServlet?password=" + pass, true);
    http.onreadystatechange= functionToRunPass;
    http.send(null);

}

function validateCategory(category) {

    http.abort();
    http.open("GET", "validationServlet?category=" + category, true);
    http.onreadystatechange= functionToRunCategory;
    http.send(null);

}

function validateDescription(description) {

    var employee = document.getElementById("employee").value;

    http.abort();
    http.open("GET", "validationServlet?description=" + description + "&employee=" + employee, true);
    http.onreadystatechange= functionToRunDescription;
    http.send(null);

}

function validateName(name) {

    if(name == ""){

        if(document.getElementById("yesEmail") && document.getElementById("yesPassword") && document.getElementById("yesRepassword")){

            document.getElementById("messageName").innerHTML = "<img src=\"images/warning.png\" alt=\"Imagen\" width=\"30px\" /><span id=\"noName\" style=\"color: orange; font-family:verdana \"> We'd like to know your name!</span>";


        }

    }else{

        document.getElementById("messageName").innerHTML = "<img src=\"images/talk.png\" alt=\"Imagen\" width=\"30px\" /> <span id=\"yesName\" style=\"color: green; font-family:verdana \"> Nice to meet you " + name + "!</span>";


    }

}


function validateHours(hours) {

    if(hours == ""){

        document.getElementById("messageHours").textContent = "";
        document.getElementById("InsertTask").disabled = true;

    }else{

        if(hours < 0 ){


            document.getElementById("messageHours").innerHTML = "<img src=\"images/false.png\" alt=\"Imagen\" width=\"30px\" /><span id=\"noHours\" style=\"color: red; font-family:verdana \"> Hours must be positives</span>";
            document.getElementById("InsertTask").disabled = true;

        

        }else{

            if(isNaN(hours)){

                document.getElementById("messageHours").innerHTML = "<img src=\"images/false.png\" alt=\"Imagen\" width=\"30px\" /><span id=\"noHours\" style=\"color: red; font-family:verdana \"> Only numbers, please.</span>";
                document.getElementById("InsertTask").disabled = true;

            }else{

                if(hours > 1000){

                    document.getElementById("messageHours").innerHTML = "<img src=\"images/false.png\" alt=\"Imagen\" width=\"30px\" /><span id=\"noHours\" style=\"color: red; font-family:verdana \"> Max. 1000 hours!</span>";
                    document.getElementById("InsertTask").disabled = true;

                }else{

                    document.getElementById("messageHours").innerHTML = "<img src=\"images/true.png\" alt=\"Imagen\" width=\"30px\" /> <span id=\"yesHours\" style=\"color: green; font-family:verdana \"> Great!</span>";

                    if(document.getElementById("yesDescription") && document.getElementById("yesHours") && document.getElementById("yesMinutes") && document.getElementById("messageMinutes").textContent != ""){
                        document.getElementById("InsertTask").disabled = false;

                    }

                }
            }

        }

    }
}



function validateMinutes(minutes) {


    if(minutes == ""){

        document.getElementById("messageMinutes").textContent = "";
        document.getElementById("InsertTask").disabled = true;


    }else{


        if(minutes < 0 ){


            document.getElementById("messageMinutes").innerHTML = "<img src=\"images/false.png\" alt=\"Imagen\" width=\"30px\" /><span id=\"nMinutes\" style=\"color: red; font-family:verdana \"> Minutes must be positives</span>";
            document.getElementById("InsertTask").disabled = true;



        }else{

            if(isNaN(minutes)){

                document.getElementById("messageMinutes").innerHTML = "<img src=\"images/false.png\" alt=\"Imagen\" width=\"30px\" /><span id=\"noMinutes\" style=\"color: red; font-family:verdana \"> Only numbers, please.</span>";
                document.getElementById("InsertTask").disabled = true;

            }else{

                if(minutes > 59){

                    document.getElementById("messageMinutes").innerHTML = "<img src=\"images/false.png\" alt=\"Imagen\" width=\"30px\" /><span id=\"noMinutes\" style=\"color: red; font-family:verdana \"> Max. 59 minutes! Add one hour more. </span>";
                    document.getElementById("InsertTask").disabled = true;
                }else{

                    document.getElementById("messageMinutes").innerHTML = "<img src=\"images/true.png\" alt=\"Imagen\" width=\"30px\" /> <span id=\"yesMinutes\" style=\"color: green; font-family:verdana \"> Great!</span>";
                    if(document.getElementById("yesDescription") && document.getElementById("yesHours") && document.getElementById("yesMinutes") && document.getElementById("messageMinutes").textContent != ""){
                        document.getElementById("InsertTask").disabled = false;

                    }

                }
            }

        }

    }
}


function validateRepass(pass) {

    if(pass != ""){

        if(pass == document.getElementById("password").value){

            if(!document.getElementById("noPassword")){

                document.getElementById("messageRepass").innerHTML = "<img src=\"images/true.png\" alt=\"Imagen\" width=\"30px\" /> <span id=\"yesRepassword\" style=\"color: green; font-family:verdana \">  Both passwords match!</span>";

                if(!document.getElementById("noEmail")){

                    if(document.getElementById("messagePass").textContent != "" && document.getElementById("messageRepass").textContent != ""){

                        document.getElementById("SignUp").disabled = false;
                    }
                }
            }
        }else{

            document.getElementById("messageRepass").innerHTML = "<img src=\"images/false.png\" alt=\"Imagen\" width=\"30px\" /><span id=\"noRepassword\" style=\"color: red; font-family:verdana \">  Passwords don't match</span>";
            document.getElementById("SignUp").disabled = true;
        }
    }else{
        document.getElementById("messageRepass").innerHTML = "";
    }

    validateName(document.getElementById("name").value);
}

function functionToRunEmail () {
    if(http.readyState == 4) {

        document.getElementById('messageEmail').innerHTML = http.responseText;

        if(document.getElementById('noEmail')){

            document.getElementById("SignUp").disabled = true;

        }else{
            if(!document.getElementById("noPassword") && !document.getElementById("noRepassword")){

                if(document.getElementById("messagePass").textContent != "" && document.getElementById("messageRepass").textContent != ""){

                    document.getElementById("SignUp").disabled = false;

                }
            }
        }
    }
}

function functionToRunPass () {
    if(http.readyState == 4) {

        document.getElementById('messagePass').innerHTML = http.responseText;
        validateRepass(document.getElementById("repassword").value);

        if(document.getElementById('noPassword')){

            document.getElementById("SignUp").disabled = true;

        }else{

            if(!document.getElementById("noEmail") && !document.getElementById("noRepassword")){

                if(document.getElementById("password").value != document.getElementById("repassword").value){


                    document.getElementById("SignUp").disabled = true;

                }else{

                    if(document.getElementById("messagePass").textContent != "" && document.getElementById("messageRepass").textContent != "")


                        document.getElementById("SignUp").disabled = false;


                }

            }

        }
    }
}

function functionToRunCategory () {
    if(http.readyState == 4) {

        document.getElementById('messageCategory').innerHTML = http.responseText;

        if(!document.getElementById('yesCategory')){

            document.getElementById("InsertCategory").disabled = true;

        }else{



            document.getElementById("InsertCategory").disabled = false;

            
                        
        }
    }
}

function functionToRunDescription () {
    if(http.readyState == 4) {

        document.getElementById('messageDescription').innerHTML = http.responseText;

        if(document.getElementById("noDescription") || document.getElementById("noHours") || document.getElementById("noMinutes") || document.getElementById("messageMinutes").textContent == "" || document.getElementById("messageHours").textContent == "" || document.getElementById("messageDescription").textContent == ""){

            document.getElementById("InsertTask").disabled = true;

        }else{

            if(document.getElementById("yesDescription") && document.getElementById("yesHours") && document.getElementById("yesMinutes")){


                document.getElementById("InsertTask").disabled = false;

            }
        }
    
    }
}
function validateOldPass(pass){
    http.abort();
    http.open("GET", "validationServlet?oldpassword=" + pass, true);
    http.onreadystatechange= functionToRunOldPass;
    http.send(null);
}

function functionToRunOldPass () {
    if(http.readyState == 4) {

        document.getElementById('messageOldPass').innerHTML = http.responseText;

        if(document.getElementById("noOldPassword") || document.getElementById("noPassword") || document.getElementById("noRepassword")){

            document.getElementById("Finish User").disabled = true;


        } else {

            document.getElementById("Finish User").disable = false;
        }

    }
}

function validatePassEdit(pass) {

    if(pass!=""){
        if(pass.length < 8){
            document.getElementById("messagePass").innerHTML = "<img src=\"images/false.png\" alt=\"Imagen\" width=\"30px\" /><span id=\"noPassword\" style=\"color: red; font-family:verdana \">  Password is too short. At least 8 characters.</span>";
        } else {
            document.getElementById("messagePass").innerHTML = "<img src=\"images/true.png\" alt=\"Imagen\" width=\"30px\" /> <span id=\"yesPassword\" style=\"color: green; font-family:verdana \">  This is a good password!</span>"
        }
    }else{
        document.getElementById("messagePass").innerHTML = "";
    }
    validateRepassEdit(document.getElementById("repassword").value);
}

function validateRepassEdit(pass) {

    if(pass != ""){

        if(pass == document.getElementById("password").value){

            if(!document.getElementById("noPassword")){

                document.getElementById("messageRepass").innerHTML = "<img src=\"images/true.png\" alt=\"Imagen\" width=\"30px\" /> <span id=\"yesRepassword\" style=\"color: green; font-family:verdana \">  Both passwords match!</span>";

                if(document.getElementById("noOldPassword") || document.getElementById("noPassword") || document.getElementById("noRepassword")){


                    document.getElementById("Finish User").disabled = true;
                }else{

                    document.getElementById("Finish User").disabled = false;
                }
            }
        }else{

            document.getElementById("messageRepass").innerHTML = "<img src=\"images/false.png\" alt=\"Imagen\" width=\"30px\" /><span id=\"noRepassword\" style=\"color: red; font-family:verdana \">  Passwords don't match</span>";

        }
    }else{
        document.getElementById("messageRepass").innerHTML = "";
    }
}

function status(entrada){
    if(entrada.value == 'Coordinator'){

        document.getElementById("boss").disabled = true;

    }else{

        document.getElementById("boss").disabled = false;

    }

}

/*
function checkMessage(){
    var counter;
    if(document.getElementById("success")){

        var date = new Date();

        var seconds =  date.getSeconds() + 10;
        counter = date.getSeconds();

        alert("Seconds: " + seconds);
        while(counter <= seconds){

            now = new Date();

            counter = now.getSeconds();

            alert("Counter: " + seconds);
        }

        document.getElementById("success").style.visibility = "hidden";

    }


}
*/