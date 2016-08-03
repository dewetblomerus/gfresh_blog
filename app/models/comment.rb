class Comment < ApplicationRecord
  belongs_to :authorable, polymorphic: true

  validates_presence_of :user, :body
end
