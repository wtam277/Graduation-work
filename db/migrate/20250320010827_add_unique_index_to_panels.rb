class AddUniqueIndexToPanels < ActiveRecord::Migration[7.0]
  def change
    add_index :panels, [:comic_id, :position], unique: true
    change_column_default :panels, :position, 1

    # position は 1 〜 16 の範囲に制限 (CHECK 制約を追加)
    execute <<-SQL
      ALTER TABLE panels 
      ADD CONSTRAINT check_position_range 
      CHECK (position BETWEEN 1 AND 16);
    SQL
  end
end