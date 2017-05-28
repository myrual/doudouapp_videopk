
$(document).on "turbolinks:load", ->
    $ -> 
        $("a[data-trackevent]").click (e) ->
            event = $(this).data("trackevent")
            mixpanel.track(
                event
            );
  
