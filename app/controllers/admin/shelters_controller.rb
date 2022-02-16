class Admin::SheltersController < ApplicationController
    def index
        all_shelters = Shelter.all
        @shelters = Shelter.order_by_name_desc
    end

    def show
        @shelter = Shelter.find(params[:id])
        @shelter_info = Shelter.name_and_city(params)
    end

end