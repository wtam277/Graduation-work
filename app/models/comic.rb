class Comic < ApplicationRecord
  belongs_to :user
  has_many :story_maps, dependent: :destroy 
  has_many :story_parts, dependent: :destroy 
  has_many :characters, dependent: :destroy

  validates :title, presence: true
  validates :total_page, presence: true, numericality: { only_integer: true, greater_than: 0 }
end
