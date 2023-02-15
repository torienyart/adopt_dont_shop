class ApplicationPetsController < ApplicationController

  def create
    @app_pet = ApplicationPet.create!(app_pet_params)
    redirect_to "/applications/#{@app_pet.application_id}"
  end

  def update
    @application = Application.find(params[:id])
    @pet = Pet.find(params[:pet])
    @app_pet = ApplicationPet.where(application_id: params[:id], pet_id: params[:pet]).first
    @app_pet.update_status(@app_pet, params[:status])
    redirect_to "/admin/applications/#{@application.id}"
  end

  private
  def app_pet_params
    params.permit(:application_id, :pet_id)
  end
end