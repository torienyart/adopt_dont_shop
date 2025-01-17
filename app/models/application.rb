class Application < ApplicationRecord
  has_many :application_pets, dependent: :destroy
  has_many :pets, through: :application_pets
  validates :name, :street_address, :city, :state, :zip, presence: true

  def in_progress?
   status == 'In Progress'
  end

  def pets?
    if pets != []
      true
    end
  end

  def params_status(application, params_stat)
    if params_stat == 'a'
      application.update!(status: "Approved")
    elsif params_stat == 'r'
      application.update!(status: "Rejected")
    end
  end

  def update_status
    if pets? && description?
      self.update(status: "Pending")
    else       
      self.update(status: "In Progress")
    end
    self
  end
end