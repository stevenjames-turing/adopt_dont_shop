require 'rails_helper'

RSpec.describe Shelter, type: :model do
  describe 'relationships' do
    it { should have_many(:pets) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:rank) }
    it { should validate_numericality_of(:rank) }
  end

  before(:each) do
    @shelter_1 = Shelter.create!(name: 'Dumb Friends League', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create!(name: 'Hollywood Shelter', city: 'Irvine, CA', foster_program: false, rank: 7)
    @shelter_3 = Shelter.create!(name: 'EAPL', city: 'Evergreen, CO', foster_program: true, rank: 2)
    @shelter_4 = Shelter.create!(name: 'Arch City Adoptions', city: 'St. Louis, MO', foster_program: true, rank: 4)
    @application_1 = Application.create(name: "Steve Rogers", street_address: "990 Logan St", city: "Denver", state: "CO", zip_code: "80203")
    @application_2 = Application.create(name: "Bruce Banner", street_address: "16 Bay Oaks Ct", city: "Lake St. Louis", state: "MO", zip_code: "63367")
    @application_3 = Application.create(name: "Tony Stark", street_address: "3265 St Paul St", city: "Denver", state: "CO", zip_code: "80205")
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
    @pet_app_8 = ApplicationPet.create!(application: @application_4, pet: @pet_7)
    @pet_app_9 = ApplicationPet.create!(application: @application_4, pet: @pet_8)
    @pet_app_10 = ApplicationPet.create!(application: @application_4, pet: @pet_9)
  end

  describe 'class methods' do
    describe '#search' do
      it 'returns partial matches' do
        expect(Shelter.search("Arch")).to eq([@shelter_4])
      end
    end

    describe '#order_by_recently_created' do
      it 'returns shelters with the most recently created first' do
        expect(Shelter.order_by_recently_created).to eq([@shelter_4, @shelter_3, @shelter_2, @shelter_1])
      end
    end

    describe '#order_by_number_of_pets' do
      it 'orders the shelters by number of pets they have, descending' do
        expect(Shelter.order_by_number_of_pets).to eq([@shelter_4, @shelter_3, @shelter_1, @shelter_2])
      end
    end

    describe '#order_by_name_desc' do 
      it 'orders shelters alphabetically by name desc' do 
        expect(Shelter.order_by_name_desc).to eq([@shelter_2, @shelter_3, @shelter_1, @shelter_4])
      end
    end

    describe '#has_pending_applications' do 
      it 'finds all shelters where a pet has a pending application' do 
        expect(Shelter.has_pending_applications).to eq([@shelter_1, @shelter_3, @shelter_2])
      end
    end

    describe '#name_and_city(params)' do 
      it 'returns a records data through SQL search' do 
        expect(Shelter.name_and_city(@shelter_1)).to eq([@shelter_1])
      end
    end
  end
  
  describe 'instance methods' do
    describe '.pet_count' do
      it 'returns the number of pets at the given shelter' do
        expect(@shelter_1.pet_count).to eq(3)
      end
    end

    describe '.adoptable_pets' do
      it 'only returns pets that are adoptable' do
        expect(@shelter_1.adoptable_pets).to eq([@pet_1, @pet_2, @pet_3])
        expect(@shelter_3.adoptable_pets).to eq([@pet_6, @pet_7, @pet_8])
      end
    end
    
    describe '.adopted_pets' do 
      it 'only returns pets that have been adopted' do
         expect(@shelter_1.adopted_pets).to eq([])
         expect(@shelter_3.adopted_pets).to eq([@pet_9])
      end
    end

    describe '.alphabetical_pets' do
      it 'returns pets associated with the given shelter in alphabetical name order' do
        expect(@shelter_1.alphabetical_pets).to eq([@pet_3, @pet_2, @pet_1])
      end
    end
    
    describe '.shelter_pets_filtered_by_age' do
      it 'filters the shelter pets based on given params' do
        expect(@shelter_1.shelter_pets_filtered_by_age(3)).to eq([@pet_2, @pet_3])
      end
    end
    
    describe '.pet_average_age' do 
      it 'calculates the average age of all pets at shelter' do
         expect(@shelter_4.pet_average_age).to eq(4.67)
    
      end
    end
  end
end
