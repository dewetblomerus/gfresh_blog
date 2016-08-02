require 'rails_helper'

describe 'navigating posts' do
  let(:post) do
    FactoryGirl.create(
      :post,
      title: 'Posts Now Clickable',
      body: 'Do you love my new navigation'
    )
  end

  it 'allows navigaion from the index to the show' do
    post
    visit posts_path
    click_on('Posts Now Clickable')
    expect(current_path).to eq(post_path(post))
    expect(page).to have_content('Posts Now Clickable')
    expect(page).to have_content('Do you love')
  end

  it 'allows navigaion from the show to the post' do
    post
    visit post_path(post)
    click_on('Posts')
    expect(current_path).to eq(posts_path)
    expect(page).to have_content('Posts Now Clickable')
    expect(page).to have_content('Do you love')
  end
end
