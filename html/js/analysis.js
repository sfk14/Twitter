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
    var usageInfo = document.getElementById("usageDescription");
    var retweetInfo = document.getElementById("retweetFavoriteDescription");
    var usageGraph = document.getElementByClassName("usage");
    var retweetGraph = document.getElementsByClassName("retweetFavorite");
    if(this.checked){
        selection.style.visibility = "visible";
        if(this.value == "usage"){
            usageInfo.style.display = "block";
            retweetInfo.style.display = "none";
            usageGraph.style.visibility = "visible";
            retweetGraph.style.visibility = "hidden";
        }else if(this.value == "retweetFavorite"){
            retweetInfo.style.display = "block";
            usageInfo.style.display = "none";
            retweetGraph.style.visibility = "visible";
            usageGraph.style.visibility = "hidden";
        }
    }else{
        selection.style.visibility = "hidden";
    }
}
window.onload = init;