class UserMailer < ApplicationMailer
  default from: ENV["EMAIL_FROM_ADDRESS"]

  def activation_email(user)
    ActivationToken.where(user: user).destroy_all
    at = ActivationToken.create(user: user)
    @user = user
    @link = activate_url(at.token)
    mail(to: @user.email, subject: "Activate your ISOTOPE account")
  end

end
