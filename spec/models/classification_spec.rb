require 'rails_helper'

RSpec.describe Classification, type: :model do
  it 'requires a tag and a taggable' do
    classification = Classification.new
    expect(classification.valid?).to eq(false)
  end
end
