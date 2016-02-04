class UserApplication < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true
  validates :name, presence: true, length: { maximum: 150 }
  validates :description, length: { maximum: 250 }
  validates :api_key, uniqueness: true
end
