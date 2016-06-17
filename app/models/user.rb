class User < ApplicationRecord
  validates :username, presence: true, length: { in: 3..20 }, uniqueness: true
  validates_format_of :username, with: /\A[A-Za-z0-9\.\-\_]{3,50}\z/
  validates :email, presence: true, uniqueness: true
  validates_format_of :email, with: /\A.+@.+\..+\z/
  validates :password, presence: true, length: { in: 6..50 }
  # Password confirmation is validated in the next line
  has_secure_password

  def is_superuser
    if ENV["SUPERUSERS"]
      return ENV["SUPERUSERS"].split(",").include? username
    end
  end
end
