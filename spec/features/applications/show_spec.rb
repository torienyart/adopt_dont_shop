require 'rails_helper'

describe 'Application Show Page' do 
  describe 'When I visit an applications show page' do
    let!(:shelter) {Shelter.create(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)}

    let!(:app_1) {Application.create(name: 'Jonah Hill', street_address: '65 High St', city: 'New York', state: 'NY', zip: 28938, description: 'Animals love me!', status: 'In Progress')}
    let!(:pet_1) {Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)}
    let!(:pet_2) {Pet.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)}
    let!(:pet_3) {Pet.create(adoptable: false, age: 2, breed: 'saint bernard', name: 'Beethoven', shelter_id: shelter.id)}

    it 'shows name of the applicant' do
      visit "/applications/#{app_1.id}"

      expect(page).to have_content(app_1.name)
    end

    it 'shows Full Address of the Applicant including street address, city, state, and zip code' do
      visit "/applications/#{app_1.id}"

      expect(page).to have_content(app_1.street_address)
      expect(page).to have_content(app_1.city)
      expect(page).to have_content(app_1.state)
      expect(page).to have_content(app_1.zip)
    end

    it "shows Description of why the applicant says they'd be a good home for this pet(s)" do
      visit "/applications/#{app_1.id}"

      expect(page).to have_content(app_1.description)
    end

    it "shows names of all pets that this application is for" do
      pet_1 = app_1.pets.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
      pet_2 = app_1.pets.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)
      pet_3 = app_1.pets.create(adoptable: false, age: 2, breed: 'saint bernard', name: 'Beethoven', shelter_id: shelter.id)
  
      
      visit "/applications/#{app_1.id}"

      expect(page).to have_content('Lucille Bald')
      expect(page).to have_content('Lobster')
      expect(page).to have_content('Beethoven')
    end

    it "all names of pets should be links to their show page" do
      pet_1 = app_1.pets.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
      pet_2 = app_1.pets.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)
      pet_3 = app_1.pets.create(adoptable: false, age: 2, breed: 'saint bernard', name: 'Beethoven', shelter_id: shelter.id)

      visit "/applications/#{app_1.id}"

      expect(page).to have_link('Lucille Bald')
      expect(page).to have_link('Lobster')
      expect(page).to have_link('Beethoven')

      click_link 'Lucille Bald'

      expect(page.current_path).to eq("/pets/#{pet_1.id}")

    end

    it "The Application's status, either 'In Progress', 'Pending', 'Accepted', or 'Rejected'" do
      visit "/applications/#{app_1.id}"

      #needs to change to be OR pending or accepted or rejected (could use a ruby if statement?)
      expect(page).to have_content('In Progress')
      # save_and_open_page
    end

    it 'shows an add pets section when application hasnt been submitted' do
      visit "/applications/#{app_1.id}"
      
      #might need to test for if it has been submitted or not here..... so that add pets doesn't show up after a certain point

      expect(page).to have_content('Add a Pet to this Application')
      expect(page).to have_content('In Progress')
    end

    it 'has an input field for searching pets by name' do
      visit "/applications/#{app_1.id}"

      
      expect(page).to have_field('pet_search')
    end
    
    it 'clicking submit shows matching pets by name on the application show page' do
      visit "/applications/#{app_1.id}"

      fill_in 'pet_search', with: 'Lobster'
      click_button 'Find Pet'

      expect(page.current_path).to eq("/applications/#{app_1.id}")
      expect(page).to have_content('Lobster')
      expect(page).to have_content(pet_2.breed)
      expect(page).to have_content(pet_2.age)
    end

    it 'has an Adopt this Pet button next to each pets name after search' do
      visit "/applications/#{app_1.id}"

      fill_in 'pet_search', with: 'Lucille Bald'
      click_button 'Find Pet'
      click_button 'Adopt this Pet'
      # require 'pry'; binding.pry

      expect(page.current_path).to eq("/applications/#{app_1.id}")
      expect(page).to have_content('Lucille Bald')
      expect(page).to have_content(pet_1.breed)
      expect(page).to have_content(pet_1.age)
    end
  end
end