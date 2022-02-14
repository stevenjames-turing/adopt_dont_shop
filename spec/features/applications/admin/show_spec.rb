require 'rails_helper'

RSpec.describe 'the ADMIN application show' do
    it 'approve pet for adoption' do 
        application = Application.create(name: "Steve Rogers", street_address: "990 Logan St", city: "Denver", state: "CO", zip_code: "80203", status: "Pending")    
        shelter = Shelter.create(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
        pet_1 = Pet.create(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
        pet_2 = Pet.create(name: 'Bruce', adoptable: true, age: 4, breed: 'Husky', shelter_id: shelter.id)
        ApplicationPet.create(pet: pet_2, application: application)
        ApplicationPet.create(pet: pet_1, application: application)
        
        visit "/admin/applications/#{application.id}"
        
        expect(page).to have_button("Approve Scooby")
        expect(page).to have_button("Approve Bruce")
        click_button("Approve Scooby")
        
        expect(current_path).to eq("/admin/applications/#{application.id}")
        expect(page).to_not have_button("Approve Scooby")
        expect(page).to have_content("Scooby Approved")
        expect(page).to have_button("Approve Bruce")
    end
    
    it 'reject a pet for adoption' do 
        # IDEAS
            # SET UP AN ATTRIBUTE IN THE APPLICATIONPETS TABLE FOR STATUS
            # CHANGE THAT ATTR TO REJECTED OR APPROVED AND UPDATE VIEW ACCORDINGLY
            
        application = Application.create(name: "Steve Rogers", street_address: "990 Logan St", city: "Denver", state: "CO", zip_code: "80203", status: "Pending")    
        shelter = Shelter.create(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
        pet_1 = Pet.create(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
        pet_2 = Pet.create(name: 'Bruce', adoptable: true, age: 4, breed: 'Husky', shelter_id: shelter.id)
        ApplicationPet.create(pet: pet_2, application: application)
        ApplicationPet.create(pet: pet_1, application: application)
        
        visit "/admin/applications/#{application.id}"
        
        expect(page).to have_button("Approve Scooby")
        expect(page).to have_button("Approve Bruce")
        expect(page).to have_button("Reject Scooby")
        expect(page).to have_button("Reject Bruce")
        click_button("Reject Scooby")
        
        expect(current_path).to eq("/admin/applications/#{application.id}")
        expect(page).to_not have_button("Approve Scooby")
        expect(page).to_not have_button("Reject Scooby")
        expect(page).to have_content("Scooby Rejected")
   
        expect(page).to have_button("Approve Bruce")
        expect(page).to have_button("Reject Bruce")
    end
end