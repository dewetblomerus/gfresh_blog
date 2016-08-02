require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:post) { FactoryGirl.create(:post) }
  let(:comment) { FactoryGirl.create(:comment, authorable: post) }

  it 'is valid with example attributes' do
    expect(post.valid?).to eq(true)
  end

  it 'requires a title' do
    post = Post.new(title: '')
    expect(post.valid?).to eq(false)
    expect(post.errors[:title].any?).to eq(true)
  end

  it 'requires a body' do
    post = Post.new(body: '')
    expect(post.valid?).to eq(false)
    expect(post.errors[:body].any?).to eq(true)
  end

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
