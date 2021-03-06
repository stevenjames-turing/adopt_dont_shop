require 'rails_helper'

RSpec.describe 'the application show' do
  it 'shows the application and all its attributes' do
    application = Application.create(name: "Steve Rogers", street_address: "990 Logan St", city: "Denver", state: "CO", zip_code: "80203", description: "Lover of dogs and avid poo-picker-upper.", status: "In Progress")    
    shelter = Shelter.create(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
    pet_1 = Pet.create(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
    pet_2 = Pet.create(adoptable: true, age: 4, breed: 'Husky', name: 'Bruce', shelter_id: shelter.id)
    ApplicationPet.create(pet: pet_1, application: application)
    ApplicationPet.create(pet: pet_2, application: application)

    visit "/applications/#{application.id}"
    
    expect(page).to have_content(application.name)
    expect(page).to have_content(application.street_address)
    expect(page).to have_content(application.city)
    expect(page).to have_content(application.state)
    expect(page).to have_content(application.zip_code)
    expect(page).to have_content(application.description)
    expect(page).to have_content(application.status)
    expect(page).to have_link(pet_1.name)
    expect(page).to have_link(pet_2.name)
    expect(page).to_not have_content(shelter.name)
  end
  
  it 'can search for pets for an application' do 
    application = Application.create(name: "Steve Rogers", street_address: "990 Logan St", city: "Denver", state: "CO", zip_code: "80203")    
    shelter = Shelter.create(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
    pet_1 = Pet.create(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
    pet_2 = Pet.create(adoptable: true, age: 4, breed: 'Husky', name: 'Bruce', shelter_id: shelter.id)
    ApplicationPet.create(pet: pet_2, application: application)
  
    visit "/applications/#{application.id}"
    
    expect(page).to have_content("In Progress")
    expect(page).to have_content("Add a Pet to this Application")
    fill_in 'Add a Pet to this Application', with: "Scooby"
    expect(page).to have_button("Search")
    
    click_button("Search")
    expect(current_path).to eq("/applications/#{application.id}")
    
    expect(page).to have_content("Scooby")
    expect("In Progress").to appear_before("Scooby")
  end
  
  it 'can add a pet to an application' do 
    application = Application.create(name: "Steve Rogers", street_address: "990 Logan St", city: "Denver", state: "CO", zip_code: "80203", description: "Lover of dogs and avid poo-picker-upper.")    
    shelter = Shelter.create(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
    pet_1 = Pet.create(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
    pet_2 = Pet.create(adoptable: true, age: 4, breed: 'Husky', name: 'Bruce', shelter_id: shelter.id)
    ApplicationPet.create(pet: pet_2, application: application)
    
    visit "/applications/#{application.id}"
    
    fill_in 'Add a Pet to this Application', with: "Scooby"
    click_button("Search")
    expect(page).to have_content("Scooby")
    expect(page).to have_button("Adopt this Pet")
    click_button("Adopt this Pet")
    expect(current_path).to eq("/applications/#{application.id}")
    expect(application.pets).to eq([pet_1, pet_2])
  end
  
  it 'can submit an application' do 
    application = Application.create(name: "Steve Rogers", street_address: "990 Logan St", city: "Denver", state: "CO", zip_code: "80203")    
    shelter = Shelter.create(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
    pet_1 = Pet.create(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
    pet_2 = Pet.create(adoptable: true, age: 4, breed: 'Husky', name: 'Bruce', shelter_id: shelter.id)
    ApplicationPet.create(pet: pet_2, application: application)
    
    visit "/applications/#{application.id}"
    
    fill_in 'Add a Pet to this Application', with: "Scooby"
    click_button("Search")
    click_button("Adopt this Pet")
    expect(application.pets).to eq([pet_1, pet_2])
    
    expect(page).to have_button("Submit Application")
    expect(page).to have_content("Why would you make a good pet owner?")
    fill_in 'Why would you make a good pet owner?', with: "Lover of dogs and avid poo-picker-upper."
    click_button("Submit Application")
    expect(current_path).to eq("/applications/#{application.id}")
    
    expect(page).to have_content("Pending")
    expect(page).to have_content("Scooby")
    expect(page).to have_content("Bruce")
    expect(page).to_not have_content("Add a Pet to this Application")
    expect(page).to_not have_content("Why would you make a good pet owner?")
  end
  
  it 'must have pets added to submit application' do 
    application = Application.create(name: "Steve Rogers", street_address: "990 Logan St", city: "Denver", state: "CO", zip_code: "80203")    
    shelter = Shelter.create(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
    pet_1 = Pet.create(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
    
    visit "/applications/#{application.id}"
    
    expect(page).to_not have_button("Submit Application")
    expect(page).to_not have_content("Interested in adopting:")
    
    fill_in 'Add a Pet to this Application', with: "Scooby"
    click_button("Search")
    click_button("Adopt this Pet")
    fill_in 'Why would you make a good pet owner?', with: "Lover of dogs and avid poo-picker-upper."
    click_button("Submit Application")
    
    expect(page).to have_content("Interested in adopting:")
  end
  
  it 'partial names for pet search' do 
    application = Application.create(name: "Steve Rogers", street_address: "990 Logan St", city: "Denver", state: "CO", zip_code: "80203")    
    shelter = Shelter.create(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
    pet_1 = Pet.create(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
    pet_3 = Pet.create(name: 'Scooba Steve', age: 1, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
    pet_4 = Pet.create(name: 'Scooby Doo', age: 3, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
    pet_5 = Pet.create(name: 'Scoob', age: 5, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
    pet_2 = Pet.create(adoptable: true, age: 4, breed: 'Husky', name: 'Bruce', shelter_id: shelter.id)
    ApplicationPet.create(pet: pet_2, application: application)
    
    visit "/applications/#{application.id}"
    
    expect(page).to have_content("Add a Pet to this Application")
    fill_in 'Add a Pet to this Application', with: "scoob"
    click_button("Search")
    expect(current_path).to eq("/applications/#{application.id}")
    
    expect(page).to have_content("Scooby")
    expect(page).to have_content(pet_1.name)
    expect(page).to have_content("Scooba Steve")
    expect(page).to have_content(pet_3.name)
    expect(page).to have_content("Scooby Doo")
    expect(page).to have_content(pet_4.name)
    expect(page).to have_content("Scoob")
    expect(page).to have_content(pet_5.name)
  end
  
  it 'case insensitive matches for pet search' do 
    application = Application.create(name: "Steve Rogers", street_address: "990 Logan St", city: "Denver", state: "CO", zip_code: "80203")    
    shelter = Shelter.create(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
    pet_1 = Pet.create(name: 'SCOoby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
    pet_3 = Pet.create(name: 'ScOOba Steve', age: 1, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
    pet_4 = Pet.create(name: 'scooby doo', age: 3, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
    pet_5 = Pet.create(name: 'Scoob', age: 5, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
    pet_2 = Pet.create(adoptable: true, age: 4, breed: 'Husky', name: 'Bruce', shelter_id: shelter.id)
    ApplicationPet.create(pet: pet_2, application: application)
    
    visit "/applications/#{application.id}"
    
    expect(page).to have_content("Add a Pet to this Application")
    fill_in 'Add a Pet to this Application', with: "scoob"
    click_button("Search")
    expect(current_path).to eq("/applications/#{application.id}")

    expect(page).to have_content("SCOoby")
    expect(page).to have_content(pet_1.name)
    expect(page).to have_content("ScOOba Steve")
    expect(page).to have_content(pet_3.name)
    expect(page).to have_content("scooby doo")
    expect(page).to have_content(pet_4.name)
    expect(page).to have_content("Scoob")
    expect(page).to have_content(pet_5.name)
    
  end
end 