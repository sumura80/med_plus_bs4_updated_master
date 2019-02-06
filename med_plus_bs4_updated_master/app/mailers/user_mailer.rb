class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.signup_confirmation.subject
  #
  default from: 'codetest1980@example.com'

  def signup_confirmation(user)
  	@user = user
    @greeting = "Hi"

    mail to: user.email, subject: "Sign Up Confirmation"
  end
end
