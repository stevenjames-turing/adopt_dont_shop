class Application < ApplicationRecord
    has_many :pets
    validates :name, presence: true 
    validates :street_address, presence: true
    validates :city, presence: true
    validates :state, presence: true
    validates :zip_code, presence: true
    validates :description, presence: true 
    validates :status, presence: true 
end