class Relationship < ApplicationRecord
  belongs_to :relationship_group, dependent: :destroy
  belongs_to :character_a, class_name: "Character", foreign_key: "character_a_id"
  belongs_to :character_b, class_name: "Character", foreign_key: "character_b_id"
end
