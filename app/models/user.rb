class User < ApplicationRecord
  validates :username, presence: true, length: { in: 3..20 }, uniqueness: true
  validates_format_of :username, with: /\A[A-Za-z0-9\.\-\_]{3,50}\z/
  validates :email, presence: true, uniqueness: true
  validates_format_of :email, with: /\A.+@.+\..+\z/
  validates :password, presence: true, length: { in: 6..50 }, on: :create
  # Password confirmation is validated in the next line
  has_secure_password
  before_save { self.email = email.downcase }
  after_commit :send_activation_email, on: :create

  has_many :login_tokens

  def is_superuser
    if ENV["SUPERUSERS"]
      return ENV["SUPERUSERS"].split(",").include? username
    end
  end

  def new_login_token
      return self.login_tokens.create
  end

  def refresh_login_token(serialized_login_token)
    series = LoginToken.deserialize(serialized_login_token)[:series]
    revoke_login_token(serialized_login_token)
    return self.login_tokens.create(series: series)
  end

  def revoke_login_token(serialized_login_token)
    series = LoginToken.deserialize(serialized_login_token)[:series]
    self.login_tokens.where(series: series).destroy_all
  end

  def self.from_login_token(serialized_login_token)
    token_hash = LoginToken.deserialize(serialized_login_token)
    user = find_by_id(token_hash[:user_id])
    return if !user
    if lt = user.login_tokens.find_by_series(token_hash[:series])
      # A LT from this series was found, check the token
      if lt.valid_token?(token_hash[:token])
        return user
      else
        # Existing series, outdated token. Must have been compromised.
        user.login_tokens.destroy_all
        return "WARN"
      end
    else
      return nil
    end
  end

  def send_activation_email
      UserMailer.delay.activation_email(self)
  end

end
