module SessionsHelper

  # Log in developer
  def log_in(developer)
    session[:developer_id] = developer.id
  end

  # Returns current logged in dev, if any.
  def current_developer
    @current_developer ||= Developer.find_by(id: session[:developer_id])
  end

  # returns true if given dev is currently logged in dev.
  def current_developer?(developer)
    developer == current_developer
  end

  # Returns true if dev is logged in.
  def logged_in?
    !current_developer.nil?
  end

  def log_out
    session.delete(:developer_id)
    @current_developer = nil
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
