class Character < ApplicationRecord
  belongs_to :comic
  has_one_attached :icon
  has_many :speeches, dependent: :destroy
  has_many :panels, through: :speeches
  has_many :relationships, dependent: :destroy
  has_many :relationship_groups, through: :relationships
end
