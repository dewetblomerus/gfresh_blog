require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:post) { FactoryGirl.create(:post) }
  let(:comment) { FactoryGirl.create(:comment, post: post) }

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

  it 'gets 3 most recent comments' do
    comment
    comment1 = FactoryGirl.create(:comment, post: post)
    comment2 = FactoryGirl.create(:comment, post: post)
    comment3 = FactoryGirl.create(:comment, post: post)
    expect(post.comments.size).to eq(4)
    expect(post.recent_comments.size).to eq(3)
  end

  xit 'eager loads 3 recent comments to prevent n + 1' do
    post1 = FactoryGirl.create(:post)
    post2 = FactoryGirl.create(:post)
    comment1 = FactoryGirl.create(:comment, post: post1)
    comment2 = FactoryGirl.create(:comment, post: post1)
    comment3 = FactoryGirl.create(:comment, post: post1)
    comment4 = FactoryGirl.create(:comment, post: post1)
    comment5 = FactoryGirl.create(:comment, post: post2)
    comment6 = FactoryGirl.create(:comment, post: post2)
    comment7 = FactoryGirl.create(:comment, post: post2)
    comment8 = FactoryGirl.create(:comment, post: post2)
    expect {
      posts = Post.all
      posts.each do |post|
	post.comments.size
      end
    }.to make_database_queries(count: 1)
    expect { Post.last.comments }.to make_database_queries(count: 1)
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
