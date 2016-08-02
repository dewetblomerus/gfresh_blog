require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:post) { FactoryGirl.create(:post) }
  let(:comment) { FactoryGirl.create(:comment, post: post) }

  it 'is valid with example attributes and a post' do
    expect(comment.valid?).to eq(true)
  end

  it 'requires a user' do
    comment = Comment.new(user: '')
    expect(comment.valid?).to eq(false)
    expect(comment.errors[:user].any?).to eq(true)
  end

  it 'requires a body' do
    comment = Comment.new(body: '')
    expect(comment.valid?).to eq(false)
    expect(comment.errors[:body].any?).to eq(true)
  end
end
