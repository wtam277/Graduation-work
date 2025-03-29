class Character < ApplicationRecord
  belongs_to :comic
  has_one_attached :icon
  has_many :speeches, dependent: :destroy
  has_many :panels, through: :speeches

  # キャラクターが A 側の関係
  has_many :relationships_as_a, class_name: "Relationship", foreign_key: "character_a_id", dependent: :destroy

  # キャラクターが B 側の関係
  has_many :relationships_as_b, class_name: "Relationship", foreign_key: "character_b_id", dependent: :destroy

  # すべての関係（A側+B側）をまとめて扱いたい場合（オプション）
  def relationships
    Relationship.where("character_a_id = ? OR character_b_id = ?", id, id)
  end

  # グループを取得する場合（必要に応じて）
  # has_many :relationship_groups, through: :relationships  ←これは削除 or 調整が必要
end
