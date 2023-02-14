class ApplicationPet < ApplicationRecord
  belongs_to :application
  belongs_to :pet

  def update_status(app_pet, params_stat)
    if params_stat == 'a'
      app_pet.update(status: "Approved")
    elsif params_stat == 'r'
      app_pet.update(status: "Rejected")
    end
  end
end