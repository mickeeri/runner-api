module SessionsHelper

  # Log in user
  def log_in(user)
    session[:user_id] = user.id
  end

  # Returns current logged in dev, if any.
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  # returns true if given dev is currently logged in dev.
  def current_user?(user)
    user == current_user
  end

  # Returns true if dev is logged in.
  def logged_in?
    !current_user.nil?
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

  # Redirects to stored location or default.
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  # Stores requested URL in session if get request.
  def store_location
    session[:forwarding_url] = request.url if request.get?
  end
end
