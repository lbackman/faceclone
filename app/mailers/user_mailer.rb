class UserMailer < ApplicationMailer
  default from: "info@osma.com"
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.welcome_email.subject
  #
  def welcome_email(user)
    @user = user
    @url  = new_user_session_url
    mail(to: @user.email, subject: 'Welcome to Odin Social Media App')
  end
end
