class Post < ApplicationRecord
  has_many :comments, dependent: :delete_all
  has_many :recent_comments, -> (max=3) { limit(max) }, class_name: "Comment"

  validates :title, presence: true
  validates :body, presence: true

  def recent_comments
    comments.order(created_at: :desc).limit(3)
  end
end
