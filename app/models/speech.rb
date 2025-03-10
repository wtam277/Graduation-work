class Speech < ApplicationRecord
  belongs_to :panel
  belongs_to :character
  validates :content, presence: true
end
