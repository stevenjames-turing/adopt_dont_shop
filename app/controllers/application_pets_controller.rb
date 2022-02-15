class ApplicationPetsController < ApplicationController

    def create
        application = Application.find(params[:application_id])
        pet = Pet.find(params[:pet_id])
        ApplicationPet.create(application: application, pet: pet)
        redirect_to "/applications/#{application.id}"
    end
    
    def update 
        application_pet = ApplicationPet.find_record(params[:application_id], params[:pet_id])
        application_pet.update({status: params[:status_change]})
        application = Application.find(params[:application_id])
        application.check_status
        redirect_to "/admin/applications/#{params[:application_id]}"
    end
end