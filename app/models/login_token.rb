class LoginToken < ApplicationRecord
  attr_accessor :token
  before_create :generate_series_and_token_digest
  belongs_to :user
  validates :user, presence: true

  def serialize
    return [self.user_id, self.series, self.token].join(",")
  end

  def self.deserialize(serialized_login_token)
    user_id, series, token = serialized_login_token.split(",")
    return {
      user_id: user_id,
      series: series,
      token: token
    }
  end

  def valid_token?(token)
    return BCrypt::Password.new(self.token_digest).is_password?(token)
  end

private

  def generate_series_and_token_digest
    self.series ||= SecureRandom.urlsafe_base64
    self.token = SecureRandom.urlsafe_base64
    self.token_digest = BCrypt::Password.create(self.token)
  end

end
