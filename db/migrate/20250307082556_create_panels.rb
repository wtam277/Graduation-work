class CreatePanels < ActiveRecord::Migration[7.2]
  def change
    create_table :panels do |t|
      t.references :story_part, null: false, foreign_key: true
      t.integer :position, null: false
      t.string :location, null: false
      t.timestamps
    end
  end
end
