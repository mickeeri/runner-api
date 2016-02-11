class User < ActiveRecord::Base
	has_many :user_applications, dependent: :destroy

	before_save { email.downcase! }

	# Name validation
	validates :name, presence: true, length: { maximum: 40 }

	# Email validation
  # Email-regex from https://www.railstutorial.org/book/modeling_users#code-validates_format_of_email
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
    format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }

  # Handling of user security. 
  has_secure_password

	# allow_nil to allow empty password on edit. nil passwords are captured by the has_secure_password method.
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

	# Returns hash digest of given string.
	def User.digest(string)
		# Use min cost parameter in test and high cost paramater in production.
		cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
		BCrypt::Password.create(string, cost: cost)
	end
end
