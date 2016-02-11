class SessionsController < ApplicationController


  # Create new user session when user logs in.
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # Login and redirect to user show page.
      log_in user # called in sessions_helper
      redirect_back_or user
    else
      flash.now[:danger] = 'Fel e-post eller/och lösenord'
      render 'new'
    end
  end

  # Log out
  def destroy
    log_out # called in sessions_helper
    redirect_to root_url
  end
end
