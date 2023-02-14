require 'rails_helper'

RSpec.describe ApplicationPet, type: :model do
  describe "relationships" do
    it {should belong_to :application}
    it {should belong_to :pet}
  end
  
  describe 'instance methods' do
    it 'can update params_status to approved' do
      shelter_1 = Shelter.create!(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
      app_1 = Application.create!(name: 'Jonah Hill', street_address: '65 High St', city: 'New York', state: 'NY', zip: 28938, status: "Pending", description: 'i luv animals') 
      pet_1 = app_1.pets.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter_1.id)

      app_pet = ApplicationPet.where(application_id: app_1.id, pet_id: pet_1.id).first
      app_pet.update_status(app_pet, 'a')

      expect(app_pet.status).to eq("Approved")
    end

    it 'can update params_status to rejected' do
      shelter_1 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
      app_1 = Application.create(name: 'Jonah Hill', street_address: '65 High St', city: 'New York', state: 'NY', zip: 28938, status: "Pending", description: 'i luv animals') 
      pet_1 = app_1.pets.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter_1.id)

      app_pet = ApplicationPet.where(application_id: app_1.id, pet_id: pet_1.id).first
      app_pet.update_status(app_pet, 'r')

      expect(app_pet.status).to eq("Rejected")
    end
  end
end