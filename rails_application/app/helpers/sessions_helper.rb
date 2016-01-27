module SessionsHelper

  # Log in developer
  def log_in(developer)
    session[:developer_id] = developer.id
  end

  # Returns current logged in dev, if any.
  def current_developer
    @current_developer ||= Developer.find_by(id: session[:developer_id])
  end

  # Returns true if dev is logged in.
  def logged_in?
    !current_developer.nil?
  end

  def log_out
    session.delete(:developer_id)
    @current_developer = nil
  end
end
