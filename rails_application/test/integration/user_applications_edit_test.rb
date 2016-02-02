require 'test_helper'

class UserApplicationsEditTestTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:mikael)
    @application = @user.user_applications.first
  end

  test "edit application with invalild info should fail" do
    log_in_as(@user)
    get edit_user_application_path(@application)
    assert_template 'user_applications/edit'
    patch user_application_path(@application), user_application: { name: "", description: ""}
    assert_template 'user_applications/edit'
  end

  test "edit application with valid info should succeed" do
    log_in_as(@user)
    get edit_user_application_path(@application)
    name = "Updated app name"
    description = "New description"
    patch user_application_path(@application), user_application: { name: name, description: description}
    assert_not flash[:success].empty?
    assert_redirected_to @user
    @application.reload
    assert_equal name, @application.name
    assert_equal description, @application.description
  end
end
