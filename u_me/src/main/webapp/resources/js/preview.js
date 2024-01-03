document.addEventListener("DOMContentLoaded", function() {
    var fontElement = document.getElementById("font");
    var opacity = 1; 

    var fadeInterval = setInterval(function() {
        opacity -= 0.01; 
        fontElement.style.opacity = opacity; 
        
        if (opacity <= 0) {
            clearInterval(fadeInterval); 
            window.location.href = "home"; 
        }
    }, 10); 
});
