require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:post) { FactoryGirl.create(:post) }
  let(:comment) { FactoryGirl.create(:comment, post: post) }

  describe 'when i delete the post' do
    it 'then the comment should no longer exist' do
      comment
      comments_count = Comment.all.count
      post.destroy
      expect comments_count != Comment.all.count
      error = "Couldn't find Comment with 'id'=#{comment.id}"
      expect { Comment.find(comment.id) }.to raise_error error
    end
  end
end
