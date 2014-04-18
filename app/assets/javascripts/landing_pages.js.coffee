# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->

#***********************************************************************
#
# Text-size control
#
#***********************************************************************
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



#***********************************************************************
#
# Fade-in and Fade-out
#
#***********************************************************************

  #fade-in and fade-out overlay on mouseenter and mouseleave
  $("#js-link-1").mouseenter(->
    makeActive $("#overlay-1")
  ).mouseleave ->
    makeInactive $("#overlay-1")

  $("#js-link-2").mouseenter(->
    makeActive $("#overlay-2")
  ).mouseleave ->
    makeInactive $("#overlay-2")

  $("#js-link-3").mouseenter(->
    makeActive $("#overlay-3")
  ).mouseleave ->
    makeInactive $("#overlay-3")

  $("#js-link-4").mouseenter(->
    makeActive $("#overlay-4")
  ).mouseleave ->
    makeInactive $("#overlay-4")

  $("#js-link-5").mouseenter(->
    makeActive $("#overlay-5")
  ).mouseleave ->
    makeInactive $("#overlay-5")


  ##
  # makeActive
  # 
  # remove the "active" class from the currently "active" element in the
  # DOM and add the "active" class to the passed jquery target
  ##
  makeActive = ($target) ->
    unless $target.hasClass("active")
      $(".active").removeClass("active")
      $target.addClass("active")

  ##
  # makeInactive
  # 
  # remove the "active" class from the passed jquery target
  ##
  makeInactive = ($target) ->
    $target.removeClass("active")
