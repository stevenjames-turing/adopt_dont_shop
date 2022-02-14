class Admin::ApplicationsController < ApplicationController
    def show
        # if params[:rejected] == true 
        #     #DO THIS HERE 
        # else
        #     @application = Application.find(params[:id])
        # end
        @application = Application.find(params[:id])
    end
end