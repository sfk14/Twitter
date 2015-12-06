function init(){
    var schlumpyCheck = document.getElementByID("schlumpyCheck");
    var mephistCheck = document.getElementById("mephistCheck");
    schlumpyCheck.addEventListener('change', checkChange, false);
}
function checkChange(){
    if(this.check){
        
    }else{
        
    }
}
window.onload = init;