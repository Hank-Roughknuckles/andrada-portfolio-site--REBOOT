# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  originalHeader = $('#header_form').val()
  originalDescription = $('#description_form').val()
  originalButtonTitle = $('#button_title_form').val()

  $("#header_form").keyup ->
    $('#header_preview').html($("#header_form").val())
    if $("#header_form").val() != originalHeader
      showSaveReminder()
    else
      hideSaveReminder()


  $("#description_form").keyup ->
    $('#description_preview').html($("#description_form").val())
    if $('#description_form').val() != originalDescription
      showSaveReminder()
    else
      hideSaveReminder()


  $("#button_title_form").keyup ->
    if $('#button_title_form').val() != originalButtonTitle
      showSaveReminder()
    else
      hideSaveReminder()


  # Change background of slide preview when upload a new image
  $("#background_image_upload").change (event) ->
    input = $(event.currentTarget)
    file = input[0].files[0]
    reader = new FileReader()
    reader.onload = (e) ->
      image_base64 = e.target.result
      $(".slide_preview, .slide").css({"background": "url(#{image_base64})"})
      showSaveReminder()

    reader.readAsDataURL file


  #Save reminder stuff
  showSaveReminder = ->
    if $(".save_reminder").text() == ""
      $(".save_reminder").text("You have changed a value. Please remember
      to press the save button.")
      $(".save").addClass("btn-danger");


  hideSaveReminder = ->
    if $("#header_form").val() == originalHeader && $('#description_form').val() == originalDescription && $('#button_title_form').val() == originalButtonTitle
      $(".save_reminder").text("")
      $(".save").removeClass("btn-danger");


  #Button title edit stuff
  $("#button_title_form").focus ->
    $("#button_title_description_helper").fadeIn(200)

  $("#button_title_form").blur ->
    $("#button_title_description_helper").fadeOut(200)
