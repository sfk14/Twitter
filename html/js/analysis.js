function init(){
    var checks = document.getElementsByTagName("input");
    for(var i = 0; i < checks.length; i++){
        checks[i].addEventListener('click', selection_made, false);
        if(checks[i].value == "usage"){
            checks[i].checked = "true";
        }
    }
}
function selection_made(){
    var selection = document.getElementById(this.value);
    if(this.checked){
        selection.style.visibility = "visible";
    }else{
        selection.style.visibility = "hidden";
    }
}
window.onload = init;