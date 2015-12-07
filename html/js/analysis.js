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
    var selections = document.getElementsByClassName(this.value);
    var usageInfo = document.getElementById("usageDescription");
    var retweetInfo = document.getElementById("retweetFavoriteDescription");
    var usageGraph = document.getElementById("usage");
    var retweetGraph = document.getElementById("retweetFavorite");
    if(this.checked){
        for(var i = 0; i < selections.length; i++){
            selections[i].style.visibility = "visible";
        }
        if(this.value == "usage"){
            usageInfo.style.display = "block";
            retweetInfo.style.display = "none";
            usageGraph.style.display = "block";
            retweetGraph.style.display = "none";
        }else if(this.value == "retweetFavorite"){
            retweetInfo.style.display = "block";
            usageInfo.style.display = "none";
            retweetGraph.style.display = "block";
            usageGraph.style.display = "none";
        }
    }else{
        for(var i = 0; i < selections.length; i++){
            selections[i].style.visibility = "hidden";
        }
    }
}
window.onload = init;