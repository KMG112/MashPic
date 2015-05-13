$(function(){

    //Append an empty grid with id="pics" to the gallery page content.


    //attach search button click handler
//   function(event) {
//       console.log("yo")
//       var key1 = $("#request_keyword1").val()
//
//         //query the Flickr API
//         $.getJSON("http://api.flickr.com/services/feeds/photos_public.gne?jsoncallback=?",
//         {
//             tags: key1,
//             format: "json"
//         }).done(function(data){return data.items[0].media.m });
//
//
//     });
//

$(".keyword1").css("background-image", "url("+$(".keyword1").text()+")")

$(".keyword2").css("background-image", "url("+$(".keyword2").text()+")")


$(".keyword3").css("background-image", "url("+$(".keyword3").text()+")")

});
