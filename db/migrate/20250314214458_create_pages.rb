class CreatePages < ActiveRecord::Migration[7.2]
  def change
    create_table :pages do |t|
      t.references :comic, null: false, foreign_key: true
      t.integer :page_number, null:false
      t.text :contnt
      t.timestamps
    end
  end
end
