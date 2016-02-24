class ResourceOwner < ActiveRecord::Base
  has_many :races, dependent: :destroy
  before_save { self.email = email.downcase }
  has_secure_password

  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
end
