class CreateCharacters < ActiveRecord::Migration[7.2]
  def change
    create_table :characters do |t|
      t.references :comic, null: false, foreign_key: true
      t.string :name, null: false
      t.text :description, null:false
      t.timestamps
    end
  end
end
