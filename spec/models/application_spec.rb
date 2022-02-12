require 'rails_helper'

RSpec.describe Application, type: :model do 
    describe 'relationships' do 
        it { should have_many(:pets)}


    end

    describe 'validations' do 
        it { should validate_presence_of(:name)}
        it { should validate_presence_of(:street_address)}
        it { should validate_presence_of(:city)}
        it { should validate_presence_of(:state)}
        it { should validate_presence_of(:zip_code)}
        it { should validate_presence_of(:description)}
        it { should validate_presence_of(:status)}
    end

    # before(:each) do 

    # end

    # describe 'class methods' do 
    #     describe 'PUT METHOD HERE' do 
    #         it 'WHAT SHOULD IT DO?' do 

    #         end
    #     end
    # end

    # describe 'instance methods' do 
    #     describe 'PUT METHOD HERE' do 
    #         it 'WHAT SHOULD IT DO?' do 

    #         end
    #     end
    # end

    
end