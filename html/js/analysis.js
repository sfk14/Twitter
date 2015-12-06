function init(){
    var checks = document.getElementsByTagName("input");
    for(var i = 0; i < checks.length; i++){
        checks[i].addEventListener('change', selection_made, false);
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