require 'rails_helper'

RSpec.describe 'the admin shelters index' do

  it 'shelters are sorted in reverse alphabetical order by name' do 
    dfl = Shelter.create!(name: 'Dumb Friends League', city: 'Aurora, CO', foster_program: false, rank: 9)
    hs = Shelter.create!(name: 'Hollywood Shelter', city: 'Irvine, CA', foster_program: false, rank: 7)
    eapl = Shelter.create!(name: 'EAPL', city: 'Evergreen, CO', foster_program: true, rank: 2)
    aca = Shelter.create!(name: 'Arch City Adoptions', city: 'St. Louis, MO', foster_program: true, rank: 4)
    
    visit "/admin/shelters"
    
    expect(hs.name).to appear_before(eapl.name)
    expect(eapl.name).to appear_before(dfl.name)
    expect(dfl.name).to appear_before(aca.name)
end

it 'shelters with pending applications' do
    shelter_1 = Shelter.create!(name: 'Dumb Friends League', city: 'Aurora, CO', foster_program: false, rank: 9)
    shelter_2 = Shelter.create!(name: 'Hollywood Shelter', city: 'Irvine, CA', foster_program: false, rank: 7)
    shelter_3 = Shelter.create!(name: 'EAPL', city: 'Evergreen, CO', foster_program: true, rank: 2)
    shelter_4 = Shelter.create!(name: 'Arch City Adoptions', city: 'St. Louis, MO', foster_program: true, rank: 4)
    application_1 = Application.create(name: "Steve Rogers", street_address: "990 Logan St", city: "Denver", state: "CO", zip_code: "80203", status: "Pending")
    application_2 = Application.create(name: "Bruce Banner", street_address: "16 Bay Oaks Ct", city: "Lake St. Louis", state: "MO", zip_code: "63367", status: "Pending")
    pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'George Hairlesson', shelter_id: shelter_1.id)
    pet_2 = Pet.create(adoptable: true, age: 3, breed: 'GSD', name: 'Charlie', shelter_id: shelter_1.id)
    pet_3 = Pet.create(adoptable: true, age: 3, breed: 'Whippet', name: 'Annabelle', shelter_id: shelter_1.id)
    pet_4 = Pet.create(adoptable: false, age: 8, breed: 'Lab', name: 'Trek', shelter_id: shelter_2.id)
    ApplicationPet.create!(application: application_1, pet: pet_1)
    ApplicationPet.create!(application: application_1, pet: pet_2)
    ApplicationPet.create!(application: application_1, pet: pet_3)
    ApplicationPet.create!(application: application_2, pet: pet_3)
    ApplicationPet.create!(application: application_2, pet: pet_4)
    
    visit "/admin/shelters"

    expect(page).to have_content("Shelter's with Pending Applications")
    
    expect(page).to have_content(shelter_1.name, count: 4)
    expect(page).to have_content(shelter_2.name, count: 4)
    expect(page).to have_content(shelter_3.name, count: 3)
    expect(page).to have_content(shelter_4.name, count: 3)
  end

  
end 