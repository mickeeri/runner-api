class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # Login and redirect to dev show page.
      log_in user
      flash[:success] = "Du är nu inloggad"
      redirect_back_or user
    else
      flash.now[:danger] = 'Fel e-post eller/och lösenord'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
