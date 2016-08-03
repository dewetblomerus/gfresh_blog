class Article < ApplicationRecord
  include Authorable
  include Taggable
end
