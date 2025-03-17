class RenameContntToContentInPages < ActiveRecord::Migration[7.2]
  def change
    rename_column :pages, :contnt, :content
  end
end
