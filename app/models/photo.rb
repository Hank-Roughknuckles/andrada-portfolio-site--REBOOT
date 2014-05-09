class Photo < ActiveRecord::Base
  IMAGE_REGEX = /\.(?:jpe?g|png|gif)(?:$|[?#])/

  validates_presence_of :link
  validates_format_of :link, with: IMAGE_REGEX
end
