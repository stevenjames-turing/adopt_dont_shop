class Application < ApplicationRecord
    has_many :application_pets
    has_many :pets, :through => :application_pets

    validates :name, presence: true 
    validates :street_address, presence: true
    validates :city, presence: true
    validates :state, presence: true
    validates :zip_code, presence: true
    validates :description, presence: true 
    validates :status, presence: true 

    def pet_search(pet_name)
        Pet.where("name ILIKE ?", "%#{pet_name}%")
    end

    def has_pets?
        pets.count > 0
    end

    def check_status
        app_statuses = application_pets.map { |app| app.status }
        if app_statuses.count < 1
            update_attribute(:status, "In Progress")
        elsif (!app_statuses.include?("Pending")) && (!app_statuses.include?("Rejected"))
            update_attribute(:status, "Approved")
        elsif (app_statuses.include?("Rejected")) && (!app_statuses.include?("Pending"))
            update_attribute(:status, "Rejected")
        end
    end
end