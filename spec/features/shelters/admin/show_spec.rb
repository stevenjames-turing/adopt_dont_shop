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

end 