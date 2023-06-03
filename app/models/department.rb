class Department < ApplicationRecord
  belongs_to :clinic
  has_many :doctors
  
  def self.generate 
    amount = Clinic.count 
    
    amount.times do |i|
      clinic = Clinic.find(i+2)
      name = Faker::Job.field
      
      new_clinic = Department.create(clinic: clinic, name: name)  
    end
    
  end
end
