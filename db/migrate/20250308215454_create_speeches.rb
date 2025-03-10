class CreateSpeeches < ActiveRecord::Migration[7.2]
  def change
    create_table :speeches do |t|
      t.references :panel, null: false, foreign_key: true
      t.references :character, null: false, foreign_key: true
      t.string :content

      t.timestamps
    end
  end
end
