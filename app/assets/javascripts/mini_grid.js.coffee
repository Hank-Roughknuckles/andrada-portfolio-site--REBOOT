$ -> #DOM ready

  grid_width = $(".gridster ul").width()
  max_columns = 6
  miniTileMarginX = 2
  miniTileMarginY = 2
  miniTileWidth = Math.round (grid_width - 2 * miniTileMarginX * (max_columns - 1) + miniTileMarginX * 2) / max_columns
  miniTileHeight = miniTileWidth


  ##
  # changeMaxWidth   
  #
  # Changes the "max" attribute of the grid_sizex form field to the passed
  # maxWidth
  #
  # @param int maxWidth - The maximum width that the currently selected
  #   tile should have 
  changeMaxWidth = ( maxWidth ) ->
    $("#edit_grid_sizex").attr("max", maxWidth)
    return


  ##
  # updateTileDebugInfo
  #
  # changes the debug information (shown in the span in each tile) for the
  # inputted tile.  The new value of the debugging info is dependent on
  # the info object in the argument.  Note: This function will only change
  # the debugging info if debugging is enabled (i.e. - there is already
  # a span child element in the tile argument)
  #
  # @param JqueryObject tile - the jquery object for a <li> element inside
  #   the gridster ul
  # @param Object info - an object with of the following form
  #   info = {  row,
  #             column,
  #             sizex,
  #             sizey  }
  updateTileDebugInfo = (tile, info) ->
    if tile.find("span").length > 0
      tile.find("span").html("row: #{info.row} <br>col: #{info.column} <br>sizex: #{info.sizex} <br>sizey: #{info.sizey}")


  #Call on page load to prevent width overflow
  changeMaxWidth max_columns + 1 - $(".highlighted").parent().attr("data-col")


  #Turn on gridster
  gridster = $(".gridster ul").gridster
    widget_margins: [miniTileMarginX, miniTileMarginY],
    widget_base_dimensions: [miniTileWidth, miniTileHeight],
    max_cols: 6,
    draggable: {
      stop: (e, ui, $widget) ->
        # change the max value of the width form field if the dragged tile
        # is the one being cropped
        if $(e.target).attr("class").match(/highlighted/)
          console.log "finished dragging"
          draggedTile = $(e.target).parent()
          changeMaxWidth( draggedTile, max_columns + 1 - draggedTile.attr("data-col") )

        setTimeout(savePositions, 200)
    }
  gridster = $(".gridster ul").gridster().data('gridster');


  # Change tile size on changing the form dimensions
  $("form #edit_grid_sizex, form #edit_grid_sizey").change  ->
    currentTile = $(".highlighted").parent()
    original_row = currentTile.attr("data-row")
    original_col = currentTile.attr("data-col")

    # gridster.resize_widget(currentTile, $("form #edit_grid_sizex").val(), $("form #edit_grid_sizey").val());
    currentTile.attr("data-sizex", $("form #edit_grid_sizex").val())
    currentTile.attr("data-sizey", $("form #edit_grid_sizey").val())
    currentTile.attr("data-row", original_row)
    currentTile.attr("data-col", original_col)
    savePositions()


  ##
  # savePositions
  #
  savePositions = ->
    # console.log "saving positions..."
    gridPositions = JSON.stringify getPositions()
    # console.log gridPositions
    # $("#grid_position_serialized_array").val(gridPositions)
    $("#grid_position_serialized_array").html(gridPositions)
    # console.log $("#serialized_array").val()
    $(".edit_grid_position").submit()
    # console.log "grid positions submitted to DB"


  ##
  # getPositions
  #
  getPositions = ->
    tilePositions = []
    $(".gridster ul li").each (i, element) ->
      if $(element).attr('data-row') && $(element).attr('data-col') && $(element).attr('data-sizex') && $(element).attr('data-sizey')
        current = 
          row:          $(element).attr('data-row')
          column:       $(element).attr('data-col')
          sizex:        $(element).attr('data-sizex')
          sizey:        $(element).attr('data-sizey')
          databaseid:   $(element).attr('data-databaseid')

        tilePositions.push current

        updateTileDebugInfo $(element), current

    return tilePositions
