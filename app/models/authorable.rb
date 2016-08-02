module Authorable
  extend ActiveSupport::Concern
  included do
    has_many :comments, as: :authorable, dependent: :delete_all

    validates :title, presence: true
    validates :body, presence: true
  end
end
