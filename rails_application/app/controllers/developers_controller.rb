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
  		flash[:success] = "Välkommen till applikationen!"
  		redirect_to @developer
  	else
  		render 'new'
  	end
  end

  private

    def developer_params
      params.require(:developer).permit(:name, :email, :password, :password_confirmation)
    end
end
