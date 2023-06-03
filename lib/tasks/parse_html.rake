require 'nokogiri'
require 'open-uri'
require 'faker'

task html_parse: [:environment] do
    doc = Nokogiri::HTML(URI.open('https://www.hospitalsafetygrade.org/all-hospitals'))
    doc.css('.content div div div ul li a').each do |a|
        clinic_name = a.content
        clinic_year = Faker::Date.between(from: '2000-01-01', to: '2010-12-12')
        clinic_address = Faker::Address.city
        
        clinic = Clinic.new(name: clinic_name, year: clinic_year, address: clinic_address)
        hospital.save
    end
end