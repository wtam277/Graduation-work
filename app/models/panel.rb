class Panel < ApplicationRecord
    belongs_to :comic
    has_many :speeches, dependent: :destroy
    has_many :characters, through: :speeches
end
