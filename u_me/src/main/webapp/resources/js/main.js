window.addEventListener("scroll", function() {
    var header = document.getElementById("header");
    var contentSection = document.querySelector(".main_pic");
    var scrollPosition = window.scrollY;

    var contentSectionTop = contentSection.offsetTop;
    var contentSectionHeight = contentSection.offsetHeight;

    if (scrollPosition > contentSectionTop && scrollPosition <= contentSectionTop + contentSectionHeight) {
        var backgroundOpacity = 0.5; 
        var textOpacity = 1;
        header.style.backgroundColor = `rgba(255, 255, 255, ${backgroundOpacity})`; 
        header.style.opacity = textOpacity; 
    } else if (scrollPosition == contentSectionTop) {
        header.style.backgroundColor = "rgba(255, 255, 255, 1)"; 
        header.style.opacity = 1; 
    }
});


document.addEventListener("DOMContentLoaded", function() {
    var modal = document.getElementById("myModal");
    var content = document.querySelectorAll(".modal-content li a");

    document.querySelector(".shop-btn").addEventListener("click", function(event) {
        event.preventDefault();
        modal.style.display = "block";
        document.querySelector(".modal-content").style.left = "0";

        content.forEach(function(element) {
            element.style.opacity = 0;
            var opacity = 0;

            var fadeInInterval = setInterval(function() {
                opacity += 0.02;
                element.style.opacity = opacity;

                if (opacity >= 1) {
                    clearInterval(fadeInInterval);
                }
            }, 10);
        });
    });

    window.addEventListener("click", function(event) {
        if (event.target == document.querySelector(".close a")) {
            modal.style.display = "none";
            document.querySelector(".modal-content").style.left = "250px";
        }
    });
});

document.addEventListener("DOMContentLoaded", function() {
    var modal = document.getElementById("hamBar");

    document.querySelector(".hMenu a").addEventListener("click", function(event) {
        event.preventDefault();
        modal.style.display = "block";
        document.querySelector(".ham-content").style.right = "0";
    });

    window.addEventListener("click", function(event) {
        if (event.target == document.querySelector(".hamClose a")) {
            modal.style.display = "none";
            document.querySelector(".ham-content").style.right = "-500px";
        }
    });
});




