ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require "minitest/reporters"
Minitest::Reporters.use!

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
  include ApplicationHelper

  # Add more helper methods to be used by all tests here...
  def is_logged_in?
    !session[:developer_id].nil?
  end

  def log_in_as(developer, options = {})
    password = options[:password] || 'password'
    if integration_test?
      post login_path, session: { email: developer.email, password: password }
    else
      session[:developer_id] = developer.id
    end
  end

  private
    def integration_test?
      defined?(post_via_redirect)
    end
end
