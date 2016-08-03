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

  it 'has tags through classifications' do
    tag = FactoryGirl.create(:tag)
    FactoryGirl.create(:classification, tag: tag, taggable: post)
    expect(post.tags.last).to eq(tag)
  end

  it 'parses tags from body' do
    post = FactoryGirl.create(
      :post,
      body: 'I am #codinglate on my #mechanicalkeyboard'
    )
    expect(post.tags.size).to eq(2)
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

  describe 'when i delete the comment' do
    it 'then the post should still exist' do
      comment
      posts_count = Post.all.count
      comment.destroy
      expect posts_count != Post.all.count
      error = "Couldn't find Post with 'id'=#{post.id}"
      expect { Post.find(post.id) }.not_to raise_error
    end
  end

  describe 'when i delete the post' do
    it 'then the classificaiton should no longer exist' do
      tag = FactoryGirl.create(:tag)
      classification = FactoryGirl.create(:classification, tag: tag, taggable: post)
      classification_count = Classification.all.count
      post.destroy
      expect classification_count != Classification.all.count
      error = "Couldn't find Classification with 'id'=#{classification.id}"
      expect { Classification.find(classification.id) }.to raise_error error
    end
  end
end
