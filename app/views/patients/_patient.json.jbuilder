json.extract! patient, :id, :name, :patient_card_id, :created_at, :updated_at
json.url patient_url(patient, format: :json)
