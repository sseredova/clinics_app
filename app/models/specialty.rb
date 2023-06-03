class Specialty < ApplicationRecord
    has_many :doctors
    
    def smth
    end
    
    def self.generate(amount) 
        amount.times do |i|
            specialty_name = Faker::Job.position
            new_specialty = Specialty.new(name: specialty_name)
            new_specialty.save
        end
    end
end

