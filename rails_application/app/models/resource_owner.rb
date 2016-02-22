class ResourceOwner < ActiveRecord::Base
  has_many :races, dependent: :destroy
  # before email is saved make sure lowercase
  before_save { self.email = email.downcase }
  has_secure_password
  #before_create :generate_access_token

  # TODO: add validation copy from user.

  #private

  # def generate_access_token
  #   begin
  #     self.access_token = SecureRandom.hex
  #   end while self.class.exists?(access_token: access_token)
  # end
end
