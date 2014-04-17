# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  ##
  # resizeText()
  #
  # resizes the font-size of the jquery object $target so that it will be
  # the same relative size as displayed in preferredRatio when the window
  # is resized.
  #
  # $target           - the jquery object that you want to change the
  #                     font-size of
  #
  # preferredRatio    - the ratio of (text-size / window-width) you want
  #                     preserved when the window is resized
  ##
  resizeText = ($target, preferredRatio) ->
    displayWidth = $(window).width()
    newFontSize = Math.round(preferredRatio * displayWidth)
    $target.css "font-size", newFontSize + "px"


  #resize the title text when the window size is changed
  $(window).bind("resize", ->
    preferredRatio = 45 / 1440
    resizeText($("#title-text"), preferredRatio)
    return
  ).trigger "resize"


  $("#js-link-1").mouseenter ->
    makeActive $("#overlay-1")

  $("#js-link-2").mouseenter ->
    makeActive $("#overlay-2")

  $("#js-link-3").mouseenter ->
    makeActive $("#overlay-3")

  $("#js-link-4").mouseenter ->
    makeActive $("#overlay-4")

  $("#js-link-5").mouseenter ->
    makeActive $("#overlay-5")


  makeActive = ($target) ->
    opacityVal = 0.2
    fadeTime = 600

    unless $target.hasClass("active")
      $(".active").animate({opacity: opacityVal}, fadeTime).removeClass("active")
      $target.animate({opacity: 0}, fadeTime).addClass("active")

    #remove active class from the active and add it to the one being moused
    #over