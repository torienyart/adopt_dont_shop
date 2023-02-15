class Pet < ApplicationRecord
  validates :name, presence: true
  validates :age, presence: true, numericality: true
  belongs_to :shelter
  has_many :application_pets, dependent: :destroy
  has_many :applications, through: :application_pets

  def shelter_name
    shelter.name
  end

  def status(app_id)
    app_pet = application_pets.where(application_id: app_id).first
    if app_pet.status == nil
      false
    elsif app_pet.status == "Approved"
      "Approved"
    elsif app_pet.status == "Rejected"
      "Rejected"
    end
  end

  def self.adoptable
    where(adoptable: true)
  end

end
