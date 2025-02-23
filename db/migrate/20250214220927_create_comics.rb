class CreateComics < ActiveRecord::Migration[7.2]
  def change
    create_table :comics do |t|
      t.references :user, null: false, foreign_key: true #user_idからの外部キー
      t.string :title, null: false  #タイトル名（必須）
      t.integer :total_page, null: false  #トータルページ数（必須）

      t.timestamps
    end
  end
end
