class ApplicationsController < ApplicationController
  def index
    @applications = Application.all
  end
  
  def show
    @application = Application.find(params[:id])
  end

  def new

  end

  def create
    new_app = Application.create(app_params)
    redirect_to"/applications/#{new_app.id}"
  end

  private
  
  def app_params
    params.permit(:name, :street_address, :city, :state, :zip, :description, :status)
  end
end