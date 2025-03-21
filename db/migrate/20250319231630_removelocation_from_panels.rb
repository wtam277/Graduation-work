class RemovelocationFromPanels < ActiveRecord::Migration[7.2]
  def change
    remove_column :panels, :location, :string
  end
end
