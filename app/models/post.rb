class Post < ApplicationRecord
  include Authorable
  include Taggable
end
