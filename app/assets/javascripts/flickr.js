$(function(){


$(".keyword1").css("background-image", "url("+$("div.keyword1").attr('value')+")")


$(".keyword3").css("background-image", "url("+$("div.keyword3").attr('value')+")")


$(".image").css("background-image", "url('https://s3.amazonaws.com/mashpic/collage.png')")

$('#clipArt').draggable();
$('#clipArt').resizable();
});

