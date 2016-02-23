class UserApplicationsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create]
  before_action :admin, only: [:index]
  before_action :admin_or_correct_user, only: [:destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :fetch_user_application, only: [:edit, :update, :destroy]

  def index
    @user_applications = UserApplication.order('name').paginate(page: params[:page])
  end

  def new
    @user_application = UserApplication.new
  end

  def create
    # current_user fetched from sessions_helper
    @user_application = current_user.user_applications.build(user_application_params)
    if @user_application.save
      flash[:success] = "#{@user_application.name} är tillagd!"
      redirect_to current_user
    else
      render 'new'
    end
  end

  def edit
    # Empty
  end

  def update
    if @user_application.update_attributes(user_application_params)
      flash[:success] = "Applikationen är uppdaterad!"
      redirect_to current_user
    else
      render 'edit'
    end
  end

  def destroy
    @user_application.destroy
    flash[:success] = "'#{@user_application.name}' är raderad!"
    # Redirect to previous or root.
    redirect_to request.referrer || root_url
  end

  private

  def user_application_params
    params.require(:user_application).permit(:name, :description)
  end

  # Fetches user applicaton as before_action to avoid DRY.
  def fetch_user_application
    @user_application = UserApplication.find(params[:id])
  end

  # Prevents other user from deleting a users application by checking that current user
  # owns application with given id.
  def correct_user
    @user_application = current_user.user_applications.find_by(id: params[:id])
    redirect_to root_url if @user_application.nil?
  end

  # Only admin or correct user should be able to delete application.
  def admin_or_correct_user
    if current_user.nil?
      redirect_to root_url
    else
      @user_application = current_user.user_applications.find_by(id: params[:id])
      unless current_user.admin?
          redirect_to root_url if @user_application.nil?
      end
    end
  end
end
