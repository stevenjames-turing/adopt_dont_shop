class ApplicationsController < ApplicationController

    # def index
    #     @applications = Application.all 
    # end
    
    def show 
        @application = Application.find(params[:id])
    end
    
    def new
    end
    
    def create
        @application = Application.new({
            name: params[:name],
            street_address: params[:street_address],
            city: params[:city],
            state: params[:state],
            zip_code: params[:zip_code]})
            if @application.save 
                redirect_to "/applications/#{@application.id}"
            else 
                redirect_to "/applications/new"
                flash[:alert] = "Error: #{error_message(@application.errors)}"
            end
        end
        
    def update 
        @application = Application.find(params[:id])
        @application.update({
            description: params[:description],
            status: "Pending"})
        redirect_to "/applications/#{@application.id}"
    end
end