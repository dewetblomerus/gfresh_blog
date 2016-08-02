require 'rails_helper'

describe 'navigating articles' do
  let(:article) do
    FactoryGirl.create(
      :article,
      title: 'Articles Now Clickable',
      body: 'Do you love my new navigation'
    )
  end

  it 'allows navigaion from the index to the show' do
    article
    visit articles_path
    click_on('Articles Now Clickable')
    expect(current_path).to eq(article_path(article))
    expect(page).to have_content('Articles Now Clickable')
    expect(page).to have_content('Do you love')
  end

  it 'allows navigaion from the show to the article' do
    article
    visit article_path(article)
    click_on('Articles')
    expect(current_path).to eq(articles_path)
    expect(page).to have_content('Articles Now Clickable')
    expect(page).to have_content('Do you love')
  end
end
