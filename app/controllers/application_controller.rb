class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :admin?, 
    :embed_media, 
    :get_background_css,
    :get_tile_image_css

  protected

  def authorize
    unless user_signed_in?
      flash[:alert] = "Unauthorized access! Please log in first."
      redirect_to root_path
      false
    end
  end

  def broken_image_tag( height = 375, width = 500, classname="")
    return "<img class=\"#{classname}\" 
    src=\"/assets/placeholder.png\" alt=\"No image added yet\" 
    width=\"#{width}\" height=\"#{height}\">".html_safe
  end

  # given a link to a vimeo video, return the id number for the video to
  # be used in the embed code in the view
  def embed_media( options = {} )
    width = options[:width] || 633
    height = options[:height] || 475

    if options[:link] && options[:uploaded_image_url]
      raise ArgumentError, "embed_media cannot have both \"link\" and
      \"uploaded_image_url\" arguments"
    end

    if options[:link]
      return embed_video(link: options[:link], 
                         width: width, 
                         height: height,
                         class: options[:class])

    elsif options[:uploaded_image_url]
      return "<img src=\"#{options[:uploaded_image_url]}\" class=\"#{options[:class]}\">".html_safe

    elsif !options[:uploaded_image_url] && !options[:link]
      return broken_image_tag(height, width, options[:class])
    end

  end

  def embed_video( options = {} )
    link = options[:link]

    if link != ""
      # if youtube
      if link =~ /youtube\.com\/.+/
        youtube_id = link.match(/v=([^&]*)/)[1]

        return "<iframe class=\"#{options[:class]}\" 
        width=\"#{options[:width]}\" height=\"#{options[:height]}\"
        src=\"//www.youtube.com/embed/#{youtube_id}\" 
        frameborder=\"0\" allowfullscreen></iframe>".html_safe

      # if vimeo
      elsif link =~ /vimeo\.com/
        vimeo_id = /^((http[s]?|ftp):\/)?\/?([^:\/\s]+)((\/\w+)*\/)([\w\-\.]+[^#?\s]+)(.*)?(#[\w\-]+)?$/.match(link)[6]

        return "<iframe class=\"#{options[:class]}\" 
        src=\"//player.vimeo.com/video/#{vimeo_id}\"
        width=\"#{options[:width]}\" height=\"#{options[:height]}\"
        frameborder=\"0\" webkitallowfullscreen mozallowfullscreen
        allowfullscreen></iframe>".html_safe
      end

    else
      return broken_image_tag options[:height], options[:width]
    end
  end

  #TODO: add documentation header
  def get_background_css(params)
    active_record_object = params[:active_record_object]
    record_id = params[:record_id]
    link = params[:link]

    if (active_record_object && !record_id) || 
      (!active_record_object && record_id)
      raise ArgumentError, "get_background_css must have both :active_record_object and :record_id params"
    end

    if active_record_object && record_id
      image = active_record_object.find(record_id).background_image
    elsif link
      image = link
    end

    if image != nil
      "background: url(#{image})"
    else
      return
    end
  end

  def get_tile_image_css(active_record_object, record_id)
    image = active_record_object.find(record_id).grid_tile_image

    if image != nil
      "background: url(#{image})"
    else
      return
    end
  end

  def save_grid_position( options = {} )
    if options[:caller].downcase == "works" 
      grid_position_record = GridPosition.find_by(parent_name: "works")
      positions = grid_position_record.serialized_array
      model = Work

    elsif options[:caller].downcase == "current_projects"
      grid_position_record = GridPosition.find_by(parent_name: "current_projects")
      positions = grid_position_record.serialized_array
      model = CurrentProject
    end

    positions = JSON.parse( positions )
    positions.each do |position|
      if position["databaseid"] == "new"
        # replace the "new" field data with the just created record's id
        position["databaseid"] = @content.id
      end

      begin
        error_occurred = false
        content = model.find( position["databaseid"] )
      rescue
        error_occurred = true
      ensure
        if !error_occurred
          content.update_attributes( grid_row: position["row"],
                                     grid_column: position["column"],
                                     grid_sizex: position["sizex"],
                                     grid_sizey: position["sizey"] )
        end
      end
  end

    # Save the position array back in GridPosition for later use
    grid_position_record.update_attributes( serialized_array: positions.map { |o| Hash[o.each_pair.to_a] }.to_json )
  end
end
