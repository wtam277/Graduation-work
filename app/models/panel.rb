class Panel < ApplicationRecord
    belongs_to :comic
    has_many :speeches, dependent: :destroy
    has_many :characters, through: :speeches
    has_many :locations, dependent: :destroy
    accepts_nested_attributes_for :locations, allow_destroy: true
    accepts_nested_attributes_for :speeches
end
