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

	# Returns hash digest of given string.
	def Developer.digest(string)
		# Use min cost parameter in test and high cost paramater in production.
		cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
		BCrypt::Password.create(string, cost: cost)
	end
end
