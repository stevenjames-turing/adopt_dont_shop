class Admin::SheltersController < ApplicationController
    def index
        all_shelters = Shelter.all
        @shelters = Shelter.order_by_name_desc
    end

    def show
        @shelter = Shelter.find_by_sql("SELECT * FROM shelters WHERE id = #{params[:id]}")
    end

end