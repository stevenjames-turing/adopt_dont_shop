class Shelter < ApplicationRecord
  validates :name, presence: true
  validates :rank, presence: true, numericality: true
  validates :city, presence: true

  has_many :pets, dependent: :destroy

  def self.order_by_recently_created
    order(created_at: :desc)
  end

  def self.order_by_number_of_pets
    select("shelters.*, count(pets.id) AS pets_count")
      .joins("LEFT OUTER JOIN pets ON pets.shelter_id = shelters.id")
      .group("shelters.id")
      .order("pets_count DESC")
  end

  def self.order_by_name_desc
    find_by_sql("SELECT * FROM shelters ORDER BY name DESC")
  end

  def self.has_pending_applications
    # shelters = find_by_sql("SELECT shelters.*
    #             FROM shelters
    #             JOIN pets ON pets.shelter_id = shelters.id
    #             JOIN application_pets ON pets.id = application_pets.pet_id
    #             JOIN applications ON application_id = applications.id
    #             WHERE applications.status LIKE 'Pending'")
    shelters = Shelter.joins(pets: [application_pets: [:application]]).order(name: :asc).distinct
  end

  def pet_count
    pets.count
  end

  def adoptable_pets
    pets.where(adoptable: true)
  end

  def alphabetical_pets
    adoptable_pets.order(name: :asc)
  end

  def shelter_pets_filtered_by_age(age_filter)
    adoptable_pets.where('age >= ?', age_filter)
  end
end
