require 'csv'
require 'faker'

task parse_csv: [:environment] do
    CSV.foreach(("hospitals.csv"), headers: false, col_sep: ",") do |row|
        clinic_name = row[0];
        clinic_address = row[1];
        clinic_category = row[3];
        clinic_rating = row[5];
        clinic_year = Faker::Date.between(from: '2000-01-01', to: '2010-12-12');
        
        clinic = Clinic.new(name: clinic_name, year: clinic_year, address: clinic_address, rating: clinic_rating, category: clinic_category)
        clinic.save
    end
end