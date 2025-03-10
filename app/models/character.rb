class Character < ApplicationRecord
  belongs_to :comic
  has_one_attached :icon
  has_many :speeches, dependent: :destroy
  has_many :panels, through: :speeches
end
