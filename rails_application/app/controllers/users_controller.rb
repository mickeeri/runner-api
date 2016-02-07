class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :destroy]
  before_action :correct_user, only: [:show, :edit, :update]
  before_action :admin, only: [:index, :destroy]
  before_action :fetch_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @applications = @user.user_applications.all
  end

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
      log_in @user
  		flash[:success] = "Välkommen #{@user.name}!"
  		redirect_to @user
  	else
  		render 'new'
  	end
  end

  def edit
    # Empty
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Konto uppdaterat"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    @user.destroy
    flash[:success] = "Användare raderad"
    redirect_to users_url
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def fetch_user
      @user = User.find(params[:id])
    end

    # Confirms that user is currently logged in user.
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
end
