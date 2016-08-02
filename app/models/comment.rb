class Comment < ApplicationRecord
  belongs_to :authorable, polymorphic: true

  validates :user, presence: true
  validates :body, presence: true
end
