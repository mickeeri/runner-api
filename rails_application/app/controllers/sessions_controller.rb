class SessionsController < ApplicationController
  def new
  end

  def create
    developer = Developer.find_by(email: params[:session][:email].downcase)
    if developer && developer.authenticate(params[:session][:password])
      # Login and redirect to dev show page.
      log_in developer
      flash[:success] = "Du är nu inloggad"
      redirect_back_or developer
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
