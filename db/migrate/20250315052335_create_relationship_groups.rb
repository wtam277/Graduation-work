class CreateRelationshipGroups < ActiveRecord::Migration[7.2]
  def change
    create_table :relationship_groups do |t|
      t.references :comic, null: false, foreign_key: true
      t.string :group_name, null:false
      t.timestamps
    end
  end
end
