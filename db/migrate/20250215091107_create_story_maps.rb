class CreateStoryMaps < ActiveRecord::Migration[7.2]
  def change
    create_table :story_maps do |t|
      t.references :comic, null: false, foreign_key: true
      t.text :summary
      t.text :description
      t.text :main_charactter
      t.text :likable_points

      t.timestamps
    end
  end
end
