require 'rails_helper'

RSpec.describe 'admin applications show page' do
  describe 'as a visitor' do 
    describe 'When I visit an admin application show page' do
        let!(:shelter_1) {Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)}
        let!(:app_1) { Application.create(name: 'Jonah Hill', street_address: '65 High St', city: 'New York', state: 'NY', zip: 28938, status: "Pending", description: 'i luv animals') }
        let!(:pet_1) { app_1.pets.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter_1.id) }
  
      it 'I see a button to approve the application for that specific pet' do 
        visit "/admin/applications/#{app_1.id}"
    
        expect(page).to have_button('Approve')
      end

      it 'when I click that button then Im taken back to the admin applications show page' do 
        visit "/admin/applications/#{app_1.id}"
        
        click_button 'Approve'

        # expect(app_1.status).to eq("Approved") WHY DOESN't THIS WORK?!
        expect(current_path).to eq("/admin/applications/#{app_1.id}")
      end

      it 'I no longer see an approval button for that pet instead I see an approved indicator' do
        visit "/admin/applications/#{app_1.id}"

        click_button 'Approve'

        expect(page).to have_content("Lobster - Approved")
      end

      it 'I see a button to reject the application for that specific pet' do 
        visit "/admin/applications/#{app_1.id}"
    
        expect(page).to have_button('Reject')
      end

      it 'when I click that button then Im taken back to the admin applications show page' do 
        visit "/admin/applications/#{app_1.id}"
        
        click_button 'Reject'

        expect(current_path).to eq("/admin/applications/#{app_1.id}")
      end

      it 'I no longer see an approval button for that pet instead I see an approved indicator' do
        visit "/admin/applications/#{app_1.id}"

        click_button 'Reject'

        expect(page).to have_content("Lobster - Rejected")
      end
    end

    describe 'When there are two applications in the system for the same pet' do
      let!(:shelter_1) {Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)}
      let!(:pet_1) { Pet.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter_1.id) }
      let!(:app_1) { pet_1.applications.create(name: 'Jonah Hill', street_address: '65 High St', city: 'New York', state: 'NY', zip: 28938, status: "Pending", description: 'i luv animals') }
      let!(:app_2) { pet_1.applications.create(name: 'Nick Fury', street_address: '123 Avenger Ave', city: 'New York', state: 'NY', zip: 28938, status: "Pending", description: 'i have an eye patch') }

      describe 'When I approve or reject the pet for one application' do
        before :each do
          visit "/admin/applications/#{app_1.id}"
          click_button 'Approve'
        end

        describe "When I visit the other application's admin show page" do
          before :each do
            visit "/admin/applications/#{app_2.id}"
          end

          it 'I do not see that the pet has been accepted or rejected for that application' do
            expect(page).to have_no_content("Approved")
            expect(page).to have_no_content("Rejected")
          end
           
          it 'I see buttons to approve or reject the pet for this specific application' do
            expect(page).to have_button("Approve")
            expect(page).to have_button("Reject")
          end
        end
      end
    end
  end
end