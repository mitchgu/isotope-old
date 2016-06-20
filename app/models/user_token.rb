class UserToken < ApplicationRecord
  attr_accessor :token
  before_create :generate_token
  belongs_to :user

  def self.from_token(token)
    return find_by_token_digest(Digest::SHA256.base64digest(token))
  end

private

  def generate_token
    self.token = SecureRandom.hex
    self.token_digest = Digest::SHA256.base64digest(self.token)
  end

end
