require 'test_helper'

class DevelopersEditTest < ActionDispatch::IntegrationTest
  def setup
    @developer = developers(:mikael)
  end


  test "edit with invalid information should fail" do
    get edit_developer_path(@developer)
    assert_template 'developers/edit'
    patch developer_path(@developer), developer: { name:  "",email: "mail@invalid",password: "hejsan",password_confirmation: "hopp" }
    assert_template 'developers/edit'
  end

  test "edit with valid credentials should succeed" do
    get edit_developer_path(@developer)
    assert_template 'developers/edit'
    name  = "Foo Bar"
    email = "foo@bar.com"
    patch developer_path(@developer), developer: { name:  name,
                                    email: email,
                                    password:              "",
                                    password_confirmation: "" }
    assert_not flash.empty?
    assert_redirected_to @developer
    @developer.reload
    assert_equal name,  @developer.name
    assert_equal email, @developer.email
  end
end
