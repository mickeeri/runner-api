class UserApplication < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true
  validates :name, presence: true, length: { maximum: 150 }
  validates :description, length: { maximum: 250 }
  validates :api_key, uniqueness: true
  before_create :generate_api_key

private

  def generate_api_key
    begin
      self.api_key = SecureRandom.hex
    end while self.class.exists?(api_key: api_key)
  end
end
