class Character < ApplicationRecord
  belongs_to :comic
  has_one_attached :icon
end
