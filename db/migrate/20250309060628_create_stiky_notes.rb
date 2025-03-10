class CreateStikyNotes < ActiveRecord::Migration[7.2]
  def change
    create_table :stiky_notes do |t|
      t.references :comic, null: false, foreign_key: true
      t.string :notable_type, null: false
      t.text :note_content
      t.string :color, default: "yellow"
      t.float :position_x, null: false, default: 0.0
      t.float :position_y, null: false, default: 0.0
      t.timestamps
    end
  end
end
