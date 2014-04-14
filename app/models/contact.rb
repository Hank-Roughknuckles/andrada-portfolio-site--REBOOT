class Contact < ActiveRecord::Base
  has_attached_file :background_image

  #email regex here
  EmailRegex = /[a-zA-Z0-9\-_]+@\w+\.(com|net|org)/i
  WebsiteRegex = /https?:\/\/[\S]+/

  validates_format_of :email, :with => EmailRegex
  validates_format_of :vimeo_id, :with => WebsiteRegex
  validates_format_of :facebook, :with => WebsiteRegex

  before_validation :strip_whitespace, :check_http

  private
  def strip_whitespace
    self.email = self.email.strip
    self.vimeo_id = self.vimeo_id.strip
    self.facebook = self.facebook.strip
  end

  def check_http
    self.vimeo_id =  prepend_http self.vimeo_id
    self.facebook =  prepend_http self.facebook
  end

  def prepend_http(link)
    u = URI.parse link

    # if it doesn't start with something like http:// or ftp://, prepend
    # http://
    if not u.scheme
      return "http://#{link}"
    else
      return link
    end
  end
  
end
