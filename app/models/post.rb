class Post < ApplicationRecord
  include Authorable
  include Taggable
  after_save :build_tags
end
