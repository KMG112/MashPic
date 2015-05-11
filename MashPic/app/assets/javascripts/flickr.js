$(function(){

    //Append an empty grid with id="pics" to the gallery page content.


    //attach search button click handler
    $(".searchbutton").click(function() {
      console.log("yo")

      $("<div>").attr("id", "pics").attr("class", "ui-grid-b").appendTo('#show [data-role="content"]');

        //query the Flickr API
        $.getJSON("https://api.flickr.com/services/feeds/photos_public.gne?jsoncallback=?",
        {
            tags: $("#tags").val(),
            format: "json"
        },
        function(data) {
            $.each(data.items, function(i,item){
                //append image to the grid, wrap with a link tag so it's clickable
                $("<img/>").attr("src", item.media.m).appendTo("#pics").wrap("<a href=" + item.link + "></a>");
                if ( i >= 8 ) return false; //display 9 images
            });
            debugger;
        });

        //switch to the gallery page after search

    });

});
