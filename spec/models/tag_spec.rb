require 'rails_helper'

RSpec.describe Tag, type: :model do
  let(:tag) { FactoryGirl.create(:tag) }
  it 'is valid with example attributes' do
    expect(tag.valid?).to eq(true)
  end

  it 'requires a title' do
    empty_tag = Tag.new
    expect(empty_tag.valid?).to eq(false)
    #expect(empty_tag.errors[:title].any?).to eq(true)
  end

  describe 'when I delete the tag' do
    it' deletes the classification' do
      post = FactoryGirl.create(:post)
      classification = FactoryGirl.create(:classification, tag: tag)
    end
  end
end
