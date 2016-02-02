class UserApplicationsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create]
  before_action :admin, only: [:index, :destroy]
  before_action :correct_user, only: [:destroy, :edit, :update]

  def index
    @user_applications = UserApplication.order('user_id').paginate(page: params[:page])
  end

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

  def edit
    @user_application = UserApplication.find(params[:id])
  end

  def update
    @user_application = UserApplication.find(params[:id])
    if @user_application.update_attributes(user_application_params)
      flash[:success] = "Applikation uppdaterad"
      redirect_to current_user
    else
      render 'edit'
    end
  end

  def destroy
    UserApplication.find(params[:id]).destroy
    # user = application.user_id
    # application.destroy
    flash[:success] = "Applikationen raderad."
    redirect_to request.referrer || root_url
    # Redirect to previous url or root.
    # if current_user && current_user.admin?
    #   redirect_to user_applications_path
    # else
    #   redirect_to current_user
    # end
  end

  private
    def user_application_params
      params.require(:user_application).permit(:name, :description)
    end

    # Prevents other user from deleting a users application by checking that current user
    # has application with given id.
    def correct_user
      @user_application = current_user.user_applications.find_by(id: params[:id])
      redirect_to root_url if @user_application.nil? unless current_user.admin?
    end

end
