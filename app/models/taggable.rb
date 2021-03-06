module Taggable
  extend ActiveSupport::Concern
  included do
    has_many :classifications, as: :taggable, dependent: :delete_all
    has_many :tags, through: :classifications
  end

  def build_tags
    tag_strings.each do |tag_string|
      tags.create(title: tag_string)
    end
  end

  def tag_strings
    body.scan(/#\w+/)
  end
end
