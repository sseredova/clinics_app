class CreateDoctors < ActiveRecord::Migration[5.0]
  def change
    create_table :doctors do |t|
      t.string :name
      t.belongs_to :department, foreign_key: true
       t.belongs_to :specialty, foreign_key: true

      t.timestamps
    end
  end
end
