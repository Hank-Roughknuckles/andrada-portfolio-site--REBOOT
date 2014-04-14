$ -> #DOM ready

  $("#media_link_input").focus ->
    $("#media_choice_radio_link").prop("checked", true)

  $("#media_image_upload").change (event) ->
    $("#media_choice_radio_upload").prop("checked", true)
