require 'rails_helper'

RSpec.describe 'the admin shelters show' do
    
    it 'shows shelter name and full address' do 
        shelter_3 = Shelter.create!(name: 'EAPL', city: 'Evergreen, CO', foster_program: true, rank: 2)
        shelter_4 = Shelter.create!(name: 'Arch City Adoptions', city: 'St. Louis, MO', foster_program: true, rank: 4)
        
        visit "/admin/shelters/#{shelter_4.id}"
        
        expect(page).to have_content(shelter_4.name)
        expect(page).to have_content(shelter_4.city)
        expect(page).to_not have_content(shelter_4.rank)
        expect(page).to_not have_content("Pets at Arch City")
        expect(page).to_not have_content(shelter_3.name)
        expect(page).to_not have_content(shelter_3.city)
    end
    
    it 'has average age of all adoptable pets' do 
        shelter_3 = Shelter.create!(name: 'EAPL', city: 'Evergreen, CO', foster_program: true, rank: 2)
        shelter_4 = Shelter.create!(name: 'Arch City Adoptions', city: 'St. Louis, MO', foster_program: true, rank: 4)
        pet_10 = Pet.create!(adoptable: true, age: 8, breed: 'Chihuahua', name: 'Nacho', shelter_id: shelter_4.id)
        pet_11 = Pet.create!(adoptable: true, age: 9, breed: 'Dachsund', name: 'Busch', shelter_id: shelter_4.id)
        pet_12 = Pet.create!(adoptable: true, age: 2, breed: 'Corgi', name: 'Yoda', shelter_id: shelter_4.id)
        pet_13 = Pet.create!(adoptable: true, age: 1, breed: 'Border Collie', name: 'Louie', shelter_id: shelter_4.id)
        pet_14 = Pet.create!(adoptable: true, age: 4, breed: 'Terrier', name: 'Clark', shelter_id: shelter_4.id)
        pet_15 = Pet.create!(adoptable: true, age: 4, breed: 'Great Dane', name: 'Buff', shelter_id: shelter_4.id)
        
        visit "/admin/shelters/#{shelter_4.id}"

        expect(page).to have_content("Shelter Statistics")
        expect(page).to have_content("Average Age: #{shelter_4.pet_average_age}")
        expect(page).to_not have_content("Average Age: #{shelter_3.pet_average_age}")
    end

    it 'has total number of all adoptable pets' do 
        shelter_3 = Shelter.create!(name: 'EAPL', city: 'Evergreen, CO', foster_program: true, rank: 2)
        shelter_4 = Shelter.create!(name: 'Arch City Adoptions', city: 'St. Louis, MO', foster_program: true, rank: 4)
        pet_10 = Pet.create!(adoptable: true, age: 8, breed: 'Chihuahua', name: 'Nacho', shelter_id: shelter_4.id)
        pet_11 = Pet.create!(adoptable: true, age: 9, breed: 'Dachsund', name: 'Busch', shelter_id: shelter_4.id)
        pet_12 = Pet.create!(adoptable: true, age: 2, breed: 'Corgi', name: 'Yoda', shelter_id: shelter_4.id)
        pet_13 = Pet.create!(adoptable: true, age: 1, breed: 'Border Collie', name: 'Louie', shelter_id: shelter_4.id)
        pet_14 = Pet.create!(adoptable: true, age: 4, breed: 'Terrier', name: 'Clark', shelter_id: shelter_4.id)
        pet_15 = Pet.create!(adoptable: true, age: 4, breed: 'Great Dane', name: 'Buff', shelter_id: shelter_4.id)
        
        visit "/admin/shelters/#{shelter_4.id}"

        expect(page).to have_content("Shelter Statistics")
        expect(page).to have_content("Number of Adoptable Pets: #{shelter_4.adoptable_pets.count}")
        expect(page).to_not have_content("Number of Adoptable Pets: #{shelter_3.adoptable_pets.count}")
    end

    it 'has total number of pets that have been adopted' do 
        shelter_3 = Shelter.create!(name: 'EAPL', city: 'Evergreen, CO', foster_program: true, rank: 2)
        shelter_4 = Shelter.create!(name: 'Arch City Adoptions', city: 'St. Louis, MO', foster_program: true, rank: 4)
        pet_10 = Pet.create!(adoptable: true, age: 8, breed: 'Chihuahua', name: 'Nacho', shelter_id: shelter_4.id)
        pet_11 = Pet.create!(adoptable: true, age: 9, breed: 'Dachsund', name: 'Busch', shelter_id: shelter_4.id)
        pet_12 = Pet.create!(adoptable: true, age: 2, breed: 'Corgi', name: 'Yoda', shelter_id: shelter_4.id)
        pet_13 = Pet.create!(adoptable: false, age: 1, breed: 'Border Collie', name: 'Louie', shelter_id: shelter_4.id)
        pet_14 = Pet.create!(adoptable: false, age: 4, breed: 'Terrier', name: 'Clark', shelter_id: shelter_4.id)
        pet_15 = Pet.create!(adoptable: true, age: 4, breed: 'Great Dane', name: 'Buff', shelter_id: shelter_4.id)
        
        visit "/admin/shelters/#{shelter_4.id}"

        expect(page).to have_content("Shelter Statistics")
        expect(page).to have_content("Number of Adoptable Pets: #{shelter_4.adoptable_pets.count}")
        expect(page).to have_content("Number of Adoptable Pets: 4")
        expect(page).to have_content("Total Pets Adopted: #{shelter_4.adopted_pets.count}")
        expect(page).to have_content("Total Pets Adopted: 2")
        expect(page).to_not have_content("Total Pets Adopted: #{shelter_3.adopted_pets.count}")
    end

end 