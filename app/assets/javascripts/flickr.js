$(function(){

// do these three lines do anything? the divs appear to be hidden...
$(".keyword1").css("background-image", "url("+$("div.keyword1").attr('value')+")")
$(".keyword2").css("background-image", "url("+$("div.keyword2").attr('value')+")")
$(".keyword3").css("background-image", "url("+$("div.keyword3").attr('value')+")")

// why go through all the trouble to make this a background image using JS?
// couldn't you just create an image tag in the view and set the src there?
$(".image").css("background-image", "url('https://s3.amazonaws.com/mashpic/collage.png')")

});

