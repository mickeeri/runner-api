class DevelopersController < ApplicationController
  # Should only be able to edit and update if logged in.
  # TODO: ändra så bara admin kan se alla användare.
  before_action :logged_in_developer, only: [:edit, :update, :destroy]
  before_action :correct_developer, only: [:edit, :update]
  before_action :admin, only: [:index, :destroy]

  def index
    @developers = Developer.paginate(page: params[:page])
  end

  def show
  	@developer = Developer.find(params[:id])
  end

  def new
  	@developer = Developer.new
  end

  def create
  	@developer = Developer.new(developer_params)
  	if @developer.save
      log_in @developer
  		flash[:success] = "Välkommen till applikationen!"
  		redirect_to @developer
  	else
  		render 'new'
  	end
  end

  def edit
    @developer = Developer.find(params[:id])
  end

  def update
    @developer = Developer.find(params[:id])
    if @developer.update_attributes(developer_params)
      flash[:success] = "Konto uppdaterat"
      redirect_to @developer
    else
      render 'edit'
    end
  end

  def destroy
    Developer.find(params[:id]).destroy
    flash[:success] = "Utvecklare raderad"
    redirect_to developers_url
  end

  private

    def developer_params
      params.require(:developer).permit(:name, :email, :password, :password_confirmation)
    end

    # Confirms that user is logged in.
    def logged_in_developer
      unless logged_in?
        # Stores requested URL.
        store_location
        flash[:danger] = "Var god logga in."
        redirect_to login_url
      end
    end

    # Confirms that developer is currently logged in developer.
    def correct_developer
      @developer = Developer.find(params[:id])
      redirect_to(root_url) unless current_developer?(@developer)
    end

    # Check if developer is admin.
    def admin
      redirect_to(root_url) unless current_developer.admin?
    end
end
