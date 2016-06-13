class User < ApplicationRecord
  has_secure_password

  def is_superuser
    if ENV["SUPERUSERS"]
      return ENV["SUPERUSERS"].split(",").include? username
    end
  end
end
