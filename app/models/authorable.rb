module Authorable
  extend ActiveSupport::Concern
  included do
    has_many :comments, as: :authorable, dependent: :delete_all

    validates_presence_of :title, :body
  end
end
