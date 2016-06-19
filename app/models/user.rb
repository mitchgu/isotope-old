class User < ApplicationRecord
  before_save { self.email = email.downcase }
  validates :username, presence: true, length: { in: 3..20 }, uniqueness: true
  validates_format_of :username, with: /\A[A-Za-z0-9\.\-\_]{3,50}\z/
  validates :email, presence: true, uniqueness: true
  validates_format_of :email, with: /\A.+@.+\..+\z/
  validates :password, presence: true, length: { in: 6..50 }
  # Password confirmation is validated in the next line
  has_secure_password
  after_commit :send_activation_email, on: :create

  def is_superuser
    if ENV["SUPERUSERS"]
      return ENV["SUPERUSERS"].split(",").include? username
    end
  end

private

  def send_activation_email
      UserMailer.delay.activation_email(self)
  end

end
