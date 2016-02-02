class UserApplicationsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :destroy]
  before_action :correct_user, only: :destroy

  def new
      @user_application = UserApplication.new
  end

  def create
    @user_application = current_user.user_applications.build(user_application_params)
    @user_application.api_key = SecureRandom.hex
    if @user_application.save
      flash[:success] = "Applikation tillagd!"
      redirect_to current_user
    else
      render 'new'
    end
  end

  def destroy
    UserApplication.find(params[:id]).destroy
    flash[:success] = "Applikation raderad."
    # Redirect to previous url or root.
    redirect_to current_user
  end

  private
    def user_application_params
      params.require(:user_application).permit(:name, :description)
    end

    # Prevents other user from deleting a users application by checking that current user
    # has application with given id.
    def correct_user
      @user_application = current_user.user_applications.find_by(id: params[:id])
      redirect_to root_url if @user_application.nil?
    end

end
