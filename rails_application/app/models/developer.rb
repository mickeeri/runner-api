class Developer < ActiveRecord::Base
	before_save { email.downcase! }

	# Name validation
	validates :name, presence: true, length: { maximum: 40 }

	# Email validation
  # Email-regex from https://www.railstutorial.org/book/modeling_users#code-validates_format_of_email
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }

  # Password validation
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
end