class DevelopersController < ApplicationController
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

  private

    def developer_params
      params.require(:developer).permit(:name, :email, :password, :password_confirmation)
    end
end
