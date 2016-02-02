require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:mikael)
    @admin = users(:admin)
  end

  # test "index of users should be paginated" do
  #   log_in_as(@admin)
  #   get users_path
  #   assert_template 'users/index'
  #   assert_select 'div.pagination'
  #   User.paginate(page: 1).each do |user|
  #     assert_select 'a[href=?]', user_path(user), text: user.name
  #   end
  # end

  test "index as admin should include delete links and be paginated" do
    log_in_as(@admin)
    get users_path
    assert_template 'users/index'
    assert_select 'div.pagination'
    User.paginate(page: 1).each do |user|
      assert_select 'p', text: user.name + " | " + user.email
      unless user == @admin
        assert_select 'a[href=?]', user_path(user), class: 'delete'
      end
    end
    # Check if user is removed if admin request to remove user.
    assert_difference 'User.count', -1 do
      delete user_path(@user)
    end
  end

  # test "index as non-admin shuld not display delete links" do
  #   log_in_as(@user)
  #   get users_path
  #   assert_select 'a', text: 'Ta bort', count: 0
  # end
end
