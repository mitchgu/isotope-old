class UserMailer < ApplicationMailer
  default from: ENV["EMAIL_FROM_ADDRESS"]
  def activation_email(user)
    @user = user
    mail(to: @user.email, subject: "Activate your ISOTOPE account")
  end
end
