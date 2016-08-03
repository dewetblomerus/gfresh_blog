module Taggable
  extend ActiveSupport::Concern
  included do
    has_many :classifications, as: :taggable, dependent: :delete_all
    has_many :tags, through: :classifications
  end
end
