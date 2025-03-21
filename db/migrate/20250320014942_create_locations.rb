class CreateLocations < ActiveRecord::Migration[7.2]
  def change
    create_table :locations do |t|
      t.references :panel, null: false, foreign_key: true
      t.string :location_name ,null: false
      t.timestamps
    end
  end
end
