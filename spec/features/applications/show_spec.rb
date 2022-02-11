require 'rails_helper'

RSpec.describe 'the application show' do
  it "shows the application and all it's attributes" do
    application = Application.create(name:"Colton Clark", address: "990 Logan St, Denver, CO 80205", description: "Lover of dogs and avid poo-picker-upper.", status: "In Progress")
    shelter = Shelter.create(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
    pet_1 = Pet.create(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id, application_id: application.id)
    pet_2 = Pet.create(adoptable: true, age: 4, breed: 'Husky', name: 'Bruce', shelter_id: shelter.id, application_id: application.id)

    visit "/applications/#{application.id}"

    expect(page).to have_content(application.name)
    expect(page).to have_content(application.address)
    expect(page).to have_content(application.description)
    expect(page).to have_content(application.status)
    expect(page).to have_content(pet_1.name)
    expect(page).to have_content(pet_2.name)
    expect(page).to_not have_content(shelter.name)
  end
end 