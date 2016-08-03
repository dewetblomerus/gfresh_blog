class Tag < ApplicationRecord
  has_many :classifications, dependent: :destroy
#  has_many :taggables, through: :classifications, source_type: "Taggable"
  validates_presence_of :title
end
