class AddColumnToClinics < ActiveRecord::Migration[5.0]
  def change
    add_column :clinics, :category, :string
    add_column :clinics, :rating, :string
    add_column :clinics, :year, :date
    
  end
end
