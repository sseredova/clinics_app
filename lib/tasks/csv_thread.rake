require 'csv'
require 'faker'

task csv_parser: [:environment] do
  threads = []

  10.times do
    threads << Thread.new do
      CSV.foreach("clinics.csv", headers: true) do |row|
        clinic_name = row['Name']
        clinic_address = row['Address']
        clinic_category = row['Category']
        clinic_rating = row['Rating']
        clinic_year = Faker::Date.between(from: '2000-01-01', to: '2010-12-12')

        clinic = Clinic.new(
          name: clinic_name,
          year: clinic_year,
          address: clinic_address,
          rating: clinic_rating,
          category: clinic_category
        )

        clinic.save
      end
    end
  end

  threads.each(&:join)
end
