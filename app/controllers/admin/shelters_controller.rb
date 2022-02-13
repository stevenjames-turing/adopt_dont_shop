class Admin::SheltersController < ApplicationController
    def index
        all_shelters = Shelter.all
        @shelters = Shelter.order_by_name_desc
    end

end