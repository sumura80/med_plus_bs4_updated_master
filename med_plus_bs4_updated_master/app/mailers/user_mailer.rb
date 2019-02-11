class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.signup_confirmation.subject
  #
  
  def signup_confirmation(user)
  	@user = user
    @greeting = "Hello"
    mail(
    from: 'codetest1980@gmail.com',
    to:   @user.email,
    subject: 'Sign Up Confirmation (Med Plus)'
  )
  end
end
