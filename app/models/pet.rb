class Pet < ApplicationRecord
  validates :name, presence: true
  validates :age, presence: true, numericality: true
  belongs_to :shelter
  has_many :application_pets
  has_many :applications, through: :application_pets

  def shelter_name
    shelter.name
  end

  def status(app_id)
    app_pet = application_pets.where(application_id: app_id).first
    app_pet.status
  end

  def self.adoptable
    where(adoptable: true)
  end

end
