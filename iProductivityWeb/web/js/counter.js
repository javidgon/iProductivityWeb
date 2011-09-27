/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */



var c=0;
var b=0;
var punto = '.';
var t;
var t2;
var timer_is_on=0;
var timer_is_on2=0;
var counter = 0;
var e3 = document.createTextNode("Solving security breaches..");
var e2 = document.createTextNode("Creating inception world..");
var e1 = document.createTextNode("Hiring good developers..");
var e4 = document.createTextNode("Ready!");
function progress()
{
    counter++;
    if(counter <= 6){

        if(counter == 1){
            document.getElementById("explanation").appendChild(e1);
        }else if(counter == 3){
            document.getElementById("explanation").removeChild(e1);
            document.getElementById("explanation").appendChild(e2);
        }else if(counter == 5){
            document.getElementById("explanation").removeChild(e2);
            document.getElementById("explanation").appendChild(e3);
        }else if(counter == 6){
            document.getElementById("explanation").removeChild(e3);
            document.getElementById("explanation").appendChild(e4);
        }
        var child = document.createTextNode(punto);
        if(punto == '.'){
            document.getElementById('txt').appendChild(child);
        }else{
            punto=punto+'.';
            document.getElementById('txt').replaceChild(document.createTextNode(c),document.createTextNode(child));
        }
        t=setTimeout("progress()",500);

    }else{
        window.location.href="iProductivityServlet?init=1";
    }
}
/*
function progressNumber()
{
    var child = document.createTextNode(c);

    document.getElementById('txt').appendChild(child);

    document.getElementById('txt').removeChild(child);
    c=c+1;
    document.getElementById('txt').appendChild(document.createTextNode(c));
    
    t=setTimeout("timedCount()",1000);

}
*/
function timedCount()
{
    document.getElementById('general').textContent=c;
    c=c+1;
    t=setTimeout("timedCount()",1000);
}


function doTimer()
{
    if (!timer_is_on)
    {
        timer_is_on=1;
        timedCount();

    }
}

function stopCount()
{
    clearTimeout(t);
    timer_is_on=0;
}


function timedCount2()
{
    document.getElementById('txt').textContent=b;
    b=b+1;
    t2=setTimeout("timedCount2()",1000);
}


function doTimer2()
{
    if (!timer_is_on2)
    {
        timer_is_on2=1;
        timedCount2();

    }
}

function stopCount2()
{
    clearTimeout(t2);
    timer_is_on2=0;
}