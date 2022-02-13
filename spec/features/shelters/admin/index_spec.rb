require 'rails_helper'

RSpec.describe 'the admin shelters index' do
#   before(:each) do
#     @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
#     @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
#     @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
#     @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
#     @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
#     @shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
#   end

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

  
end 