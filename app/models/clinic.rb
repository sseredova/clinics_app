require 'csv'

class Clinic < ApplicationRecord
    has_many :departments
    has_many :patient_cards
    has_one_attached :image
    
    
    def self.to_csv
     clinics = all
     CSV.generate do |csv|
       csv << column_names
       clinics.each do |clinic|
         csv << clinic.attributes.values_at(*column_names)
       end
     end
    end
end
