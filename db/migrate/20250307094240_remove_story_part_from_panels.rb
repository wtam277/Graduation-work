class RemoveStoryPartFromPanels < ActiveRecord::Migration[7.2]
  def change
      remove_reference :panels, :story_part, foreign_key: true
  end
end
