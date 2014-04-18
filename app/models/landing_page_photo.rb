class LandingPagePhoto < Photo
  validates_presence_of :link
  validates_format_of :link, with: /\.(?:jpe?g|png|gif)(?:$|[?#])/
end
