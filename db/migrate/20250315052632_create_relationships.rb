class CreateRelationships < ActiveRecord::Migration[7.2]
  def change
    create_table :relationships do |t|
      t.references :relationship_group, null: false, foreign_key: true
      t.references :character_a, null: false, foreign_key: { to_table: :characters }
      t.references :character_b, null: false, foreign_key: { to_table: :characters }
      t.string :relationship_type, null:false
      t.integer :directionality, null:false
      t.timestamps
    end
  end
end
