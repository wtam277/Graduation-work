class Comic < ApplicationRecord
  belongs_to :user
  has_many :story_maps, dependent: :destroy 
  has_many :story_parts, dependent: :destroy 
  has_many :characters, dependent: :destroy
  has_many :panels, dependent: :destroy
  has_many :stiky_notes, dependent: :destroy

  validates :title, presence: true
  validates :total_page, presence: true, numericality: { only_integer: true, greater_than: 0 }
end
