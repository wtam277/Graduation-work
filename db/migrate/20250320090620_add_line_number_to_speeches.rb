class AddLineNumberToSpeeches < ActiveRecord::Migration[7.2]
  def change
    add_column :speeches, :position, :integer, null: false, default: 0
    add_index :speeches, [:panel_id, :position], unique: true  # 同じ panel_id 内でユニークにする
  end
end
