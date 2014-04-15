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
    preferredRatio = 47 / 1440
    resizeText($("#title-text"), preferredRatio)
    return
  ).trigger "resize"

