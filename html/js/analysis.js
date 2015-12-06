function init(){
    var checks = document.getElementsByTagName("input");
    for(var i = 0; i < checks.length; i++){
        checks[i].addEventListener('change', selection_made, false);
        if(checks[i].value == "usage"){
            checks[i].checked = "true";
        }
    }
}
function selection_made(){
    var selection = document.getElementById(this.value);
    if(this.checked == "true"){
        if(this.type == "checkbox"){
            selection.setAttribute("opacity", 0.4);
        }else{
            selection.style.visibility = "visible";
        }
    }else{
        if(this.type == "checkbox"){
            selection.setAttribute("opacity", 0);
        }else{
            selection.style.visibility = "hidden";
        }
    }
}
window.onload = init;