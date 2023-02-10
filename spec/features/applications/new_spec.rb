require 'rails_helper' 
RSpec.describe 'Starting a new application' do
 
  it 'allows an applicant to fill out an application' do
    visit '/application/new'

    fill_in 'Name:', with: 'Amy Nelson'
    fill_in 'Street Address:', with: '123 Rainbow rd'
    fill_in 'City:', with: 'Golden'
    fill_in 'State:', with: 'Colorado'
    fill_in 'Zip Code:', with: 80401

    click_on 'Submit Application'

    expect(current_path).to eq("/applications/#{Application.last.id}")
  end
end