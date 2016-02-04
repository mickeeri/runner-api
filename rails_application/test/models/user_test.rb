require 'test_helper'

class UserTest < ActiveSupport::TestCase
	def setup
		@user = User.new(name: "Exempelanvändare", email: "dev@exempel.se",
			password: "lösenord", password_confirmation: "lösenord")
	end

	test "user should be valid" do
		assert @user.valid?
	end

	test "name should be present" do
		@user.name = ""
		assert_not @user.valid?
	end

	test "email should be present" do
		@user.email = ""
		assert_not @user.valid?
	end

	test "name should not be too long" do
		@user.name = "m" * 41
		assert_not @user.valid?
	end

	test "email should not be too long" do
		@user.email = "m" * 244 + "@example.com"
		assert_not @user.valid?
	end

	test "email should accept valid emails" do
		valid_addresses = %w[dev@exempel.com USER@example.SE AUS_ER@foo.bar.org hello.yo@ex.jp micke+eriksson@email.zs]
		valid_addresses.each do |valid_address|
			@user.email = valid_address
			assert @user.valid?, "#{valid_address.inspect} should be valid."
		end
	end

	test "email should not accept invalid email addresses" do
		invalid_addresses = %w[user@example,com user_at_mail.org user.name@example. user@e_mail.com user@e+post.com user@mail..com]
		invalid_addresses.each do |invalid_address|
			@user.email = invalid_address
			assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
		end
	end

	# Saves dev in db and then tries to validate dev with same email.
	test "email addresses should be unique" do
		duplicate_user = @user.dup
		duplicate_user.email = @user.email.upcase
		@user.save
		assert_not duplicate_user.valid?
	end

	test "email should be saved as lowercase" do
		mixed_case_email = "MaIl@gMail.COm"
		@user.email = mixed_case_email
		@user.save
		assert_equal mixed_case_email.downcase, @user.reload.email
	end

	test "password should be present" do
		@user.password = @user.password_confirmation = " " * 6
		assert_not @user.valid?
	end

	test "password should have minumum length" do
		@user.password = @user.password_confirmation = "m" * 5
		assert_not @user.valid?
	end

	test "should destroy users applications when user is deleted" do
		@user.save
		@user.user_applications.create!(name: "appen")
		assert_difference 'UserApplication.count', -1 do
			@user.destroy
		end
	end
end
