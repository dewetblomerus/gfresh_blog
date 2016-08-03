require 'rails_helper'

RSpec.describe Tag, type: :model do
  let(:tag) { FactoryGirl.create(:tag) }
  it 'is valid with example attributes' do
    expect(tag.valid?).to eq(true)
  end

  it 'requires a title' do
    empty_tag = Tag.new
    expect(empty_tag.valid?).to eq(false)
    expect(empty_tag.errors[:title].any?).to eq(true)
  end

  xit 'has taggables through classifications' do
    article = FactoryGirl.create(:article)
    classification = FactoryGirl.create(:classification, tag: tag, taggable: article)
    expect(tag.taggables.last).to eq(article)
  end

  describe 'when I delete the tag' do
    it 'the classification should no longer exist' do
      post = FactoryGirl.create(:post)
      classification = FactoryGirl.create(:classification, tag: tag, taggable: post)
      classification_count = Classification.all.count
      tag.destroy
      expect classification_count != Classification.all.count
      error = "Couldn't find Classification with 'id'=#{classification.id}"
      expect { Classification.find(classification.id) }.to raise_error error
    end
  end
end
