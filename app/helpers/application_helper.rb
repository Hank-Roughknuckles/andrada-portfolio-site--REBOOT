module ApplicationHelper

  def make_title( page_title )
    full_title = "Andrada Popan-Dorca"

    if page_title.empty?
      return full_title
    else
      return "#{full_title} - #{page_title}"
    end
  end


  def remove_http(link)
    return link.sub /http:\/\//, ""
  end
end
