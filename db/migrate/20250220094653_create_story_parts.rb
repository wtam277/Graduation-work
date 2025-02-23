class CreateStoryParts < ActiveRecord::Migration[7.2]
  def change
    create_table :story_parts do |t|
      t.references :comic, null: false, foreign_key: true
      t.string :content, null: false
      t.integer :part_type, default: 0, null: false

      t.timestamps
    end
  end
end
