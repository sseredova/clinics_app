Rails.application.routes.draw do
  
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  
  get "/clinics/export.csv", to: "clinics#export_csv"
  
  devise_for :users
  resources :patient_cards
  resources :patients
  resources :doctors
  resources :specialties
  resources :departments
  resources :clinics
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  get '/clinics/download/pdf/:id', to: 'clinics#download_pdf', as: "download_pdf"

  
  root "clinics#index"
  
end
