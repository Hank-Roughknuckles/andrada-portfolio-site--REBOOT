class ContactMailer < ActionMailer::Base
  default to: User.first.email

  def contact_email(sender, message)
    @sender = sender
    @message = message

    mail(from: "themongolempire@gmail.com", 
         subject: "Message from your portfolio site")
  end
end
