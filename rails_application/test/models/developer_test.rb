require 'test_helper'

class DeveloperTest < ActiveSupport::TestCase
	def setup
		@developer = Developer.new(name: "Exempelanvändare", email: "dev@exempel.se",
			password: "lösenord", password_confirmation: "lösenord")
	end

	test "developer should be valid" do
		assert @developer.valid?
	end

	test "name should be present" do
		@developer.name = ""
		assert_not @developer.valid?
	end

	test "email should be present" do
		@developer.email = ""
		assert_not @developer.valid?
	end

	test "name should not be too long" do
		@developer.name = "m" * 41
		assert_not @developer.valid?
	end

	test "email should not be too long" do
		@developer.email = "m" * 244 + "@example.com"
		assert_not @developer.valid?
	end

	test "email should accept valid emails" do
		valid_addresses = %w[dev@exempel.com USER@example.SE AUS_ER@foo.bar.org hello.yo@ex.jp micke+eriksson@email.zs]
		valid_addresses.each do |valid_address|
			@developer.email = valid_address
			assert @developer.valid?, "#{valid_address.inspect} should be valid."
		end
	end

	# test "should not accept invalid email addresses" do
	# 	invalid_addresses = %w[user@example,com user.hotmail.com developer.name@example. hello@foo_bar.zs foo@bar+bz.com email@mail..com]
	# 	invalid_addresses.each do |invalid_address|
	# 		@developer.email = invalid_address
	# 		assert @developer.valid?, "#{invalid_address.inspect} should not be valid."
	# 	end
	# end

	test "email should not accept invalid email addresses" do
		invalid_addresses = %w[user@example,com user_at_mail.org user.name@example. user@e_mail.com user@e+post.com user@mail..com]
		invalid_addresses.each do |invalid_address|
			@developer.email = invalid_address
			assert_not @developer.valid?, "#{invalid_address.inspect} should be invalid"
		end
	end

	# Saves dev in db and then tries to validate dev with same email.
	test "email addresses should be unique" do
		duplicate_developer = @developer.dup
		duplicate_developer.email = @developer.email.upcase
		@developer.save
		assert_not duplicate_developer.valid?
	end

	test "email should be saved as lowercase" do
		mixed_case_email = "MaIl@gMail.COm"
		@developer.email = mixed_case_email
		@developer.save
		assert_equal mixed_case_email.downcase, @developer.reload.email
	end

	test "password should be present" do
		@developer.password = @developer.password_confirmation = " " * 6
		assert_not @developer.valid?
	end

	test "password should have minumum length" do
		@developer.password = @developer.password_confirmation = "m" * 5
		assert_not @developer.valid?
	end
end