require 'rails_helper'

RSpec.describe ApplicationPet, type: :model do 
    describe 'relationships' do 
        it { should belong_to(:pet)}
        it { should belong_to(:application)}
    end
    
    before(:each) do 
        @shelter_1 = Shelter.create!(name: 'Dumb Friends League', city: 'Aurora, CO', foster_program: false, rank: 9)
        @shelter_2 = Shelter.create!(name: 'Hollywood Shelter', city: 'Irvine, CA', foster_program: false, rank: 7)
        @shelter_3 = Shelter.create!(name: 'EAPL', city: 'Evergreen, CO', foster_program: true, rank: 2)
        @shelter_4 = Shelter.create!(name: 'Arch City Adoptions', city: 'St. Louis, MO', foster_program: true, rank: 4)
        @application_1 = Application.create(name: "Steve Rogers", street_address: "990 Logan St", city: "Denver", state: "CO", zip_code: "80203")
        @application_2 = Application.create(name: "Bruce Banner", street_address: "16 Bay Oaks Ct", city: "Lake St. Louis", state: "MO", zip_code: "63367")
        @application_3 = Application.create(name: "Tony Stark", street_address: "3265 St Paul St", city: "Denver", state: "CO", zip_code: "80205", status: "Pending")
        @application_4 = Application.create(name: "Peter Parker", street_address: "2401 15th St", city: "Denver", state: "CO", zip_code: "80202")
        @pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'George Hairlesson', shelter_id: @shelter_1.id)
        @pet_2 = Pet.create(adoptable: true, age: 3, breed: 'GSD', name: 'Charlie', shelter_id: @shelter_1.id)
        @pet_3 = Pet.create(adoptable: true, age: 3, breed: 'Whippet', name: 'Annabelle', shelter_id: @shelter_1.id)
        @pet_4 = Pet.create(adoptable: false, age: 8, breed: 'Lab', name: 'Trek', shelter_id: @shelter_2.id)
        @pet_5 = Pet.create!(adoptable: true, age: 6, breed: 'Cattle Dog', name: 'Otis', shelter_id: @shelter_2.id)
        @pet_6 = Pet.create!(adoptable: true, age: 4, breed: 'Husky', name: 'Bruce', shelter_id: @shelter_3.id)
        @pet_7 = Pet.create!(adoptable: true, age: 5, breed: 'Pit', name: 'Vegas', shelter_id: @shelter_3.id)
        @pet_8 = Pet.create!(adoptable: true, age: 6, breed: 'Poodle', name: 'Oakley', shelter_id: @shelter_3.id)
        @pet_9 = Pet.create!(adoptable: false, age: 7, breed: 'Shiba Inu', name: 'Pepper', shelter_id: @shelter_3.id)
        @pet_10 = Pet.create!(adoptable: true, age: 8, breed: 'Chihuahua', name: 'Nacho', shelter_id: @shelter_4.id)
        @pet_11 = Pet.create!(adoptable: true, age: 9, breed: 'Dachsund', name: 'Busch', shelter_id: @shelter_4.id)
        @pet_12 = Pet.create!(adoptable: true, age: 2, breed: 'Corgi', name: 'Yoda', shelter_id: @shelter_4.id)
        @pet_13 = Pet.create!(adoptable: false, age: 1, breed: 'Border Collie', name: 'Louie', shelter_id: @shelter_4.id)
        @pet_14 = Pet.create!(adoptable: true, age: 4, breed: 'Terrier', name: 'Clark', shelter_id: @shelter_4.id)
        @pet_15 = Pet.create!(adoptable: true, age: 4, breed: 'Great Dane', name: 'Buff', shelter_id: @shelter_4.id)
        @pet_app_1 = ApplicationPet.create!(application: @application_1, pet: @pet_1)
        @pet_app_2 = ApplicationPet.create!(application: @application_1, pet: @pet_2)
        @pet_app_3 = ApplicationPet.create!(application: @application_1, pet: @pet_3)
        @pet_app_4 = ApplicationPet.create!(application: @application_2, pet: @pet_3)
        @pet_app_5 = ApplicationPet.create!(application: @application_2, pet: @pet_4)
        @pet_app_6 = ApplicationPet.create!(application: @application_3, pet: @pet_5)
        @pet_app_7 = ApplicationPet.create!(application: @application_3, pet: @pet_6)
    end
    
    describe 'class methods' do 
        describe '#find_record(application_id, pet_id' do 
            it 'returns the record where pet_id and application_id match passed params' do
                expect(ApplicationPet.find_record(@application_1.id, @pet_2.id)).to eq([@pet_app_2])
            end
        end
    end 
end