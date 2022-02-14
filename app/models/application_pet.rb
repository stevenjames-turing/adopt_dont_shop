class ApplicationPet < ApplicationRecord
    belongs_to :application 
    belongs_to :pet

    def self.find_record(application_id, pet_id)
        record = where("application_id = ?", application_id).
                where("pet_id = ?", pet_id)
    end
end