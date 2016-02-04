class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  # To use sessions over multiple pages.
  include SessionsHelper

  private

    # Confirms that user is logged in.
    def logged_in_user
      unless logged_in?
        # Stores requested URL for friendly forwarding.
        store_location
        flash[:danger] = "Var god logga in."
        redirect_to login_url
      end
    end

    # Check if user is admin. Redirect otherwise.
    def admin
      redirect_to(root_url) unless current_user && current_user.admin?
    end
end
