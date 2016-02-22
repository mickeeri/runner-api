class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  # TODO: uncomment.
  #protect_from_forgery with: :null_session
  # To use sessions over multiple pages.
  include SessionsHelper
  include Knock::Authenticable

  respond_to :json, :xml

  protected
    # To handle problem when user loggs out and hits the browsers back-button. Rails
    # is caching the page and we can get the previous page.Dont forget to disable
    # tubrolinks on logout-link
    def set_cache_buster
      response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
      response.headers["Pragma"] = "no-cache"
      response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
    end

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
