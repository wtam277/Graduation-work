class Panel < ApplicationRecord
    belongs_to :comic
    has_many :speeches, dependent: :destroy
    has_many :characters, through: :speeches
    has_many :locations, dependent: :destroy
    accepts_nested_attributes_for :locations, allow_destroy: true
    #speechフォームが空でも入力できるようにした
    accepts_nested_attributes_for :speeches, allow_destroy: true, reject_if: proc { |attributes| attributes['character_id'].blank? && attributes['content'].blank? } 
end
