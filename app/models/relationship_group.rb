class RelationshipGroup < ApplicationRecord
  belongs_to :comic
  has_many :relationships, dependent: :destroy
  has_many :characters, through: :relationships

  accepts_nested_attributes_for :relationships, allow_destroy: true, reject_if: :all_blank

  validates :group_name, presence: true
end
