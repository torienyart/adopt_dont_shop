class Application < ApplicationRecord
  has_many :application_pets
  has_many :pets, through: :application_pets
  validates :name, :street_address, :city, :state, :zip, :description, presence: true

  def in_progress?
    pets == []
  end
end