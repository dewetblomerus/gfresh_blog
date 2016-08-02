require 'rails_helper'

RSpec.describe Article, type: :model do
  let(:article) { FactoryGirl.create(:article) }
  let(:comment) { FactoryGirl.create(:comment, authorable: article) }

  it 'is valid with example attributes' do
    expect(article.valid?).to eq(true)
  end

  it 'requires a title' do
    article = Article.new(title: '')
    expect(article.valid?).to eq(false)
    expect(article.errors[:title].any?).to eq(true)
  end

  it 'requires a body' do
    article = Article.new(body: '')
    expect(article.valid?).to eq(false)
    expect(article.errors[:body].any?).to eq(true)
  end

  describe 'when i delete the article' do
    it 'then the comment should no longer exist' do
      comment
      comments_count = Comment.all.count
      article.destroy
      expect comments_count != Comment.all.count
      error = "Couldn't find Comment with 'id'=#{comment.id}"
      expect { Comment.find(comment.id) }.to raise_error error
    end
  end
end
