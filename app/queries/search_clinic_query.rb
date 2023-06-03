class SearchClinicQuery 
    def initialize(clinics = Clinic.all)
        @clinics = clinics
    end
    
    def search(value="")
        @clinics.where("LOWER(name) LIKE LOWER(?)", "%#{value}%")
    end
end