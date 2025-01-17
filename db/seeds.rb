# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Pet.destroy_all
# Application.destroy_all
# ApplicationPet.destroy_all
# Shelter.destroy_all

shelter = Shelter.create(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
app_1 = Application.create(name: 'Jonah Hill', street_address: '65 High St', city: 'New York', state: 'NY', zip: 28938, description: 'Animals love me!', status: 'In Progress')
pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
pet_2 = Pet.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter_1.id)
pet_3 = Pet.create(adoptable: false, age: 2, breed: 'saint bernard', name: 'Beethoven', shelter_id: shelter_2.id)
pet_4 = Pet.create(adoptable: true, age: 3, breed: 'leopard gecko', name: 'Mango', shelter_id: shelter_3.id)
