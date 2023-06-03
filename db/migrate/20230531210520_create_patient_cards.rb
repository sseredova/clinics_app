class CreatePatientCards < ActiveRecord::Migration[5.0]
  def change
    create_table :patient_cards do |t|
      t.string :number
      t.belongs_to :clinic, foreign_key: true
      t.belongs_to :patient, foreign_key: true

      t.timestamps
    end
  end
end
