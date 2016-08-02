require 'rails_helper'

describe 'adding posts' do
  it 'allows a user to create a prost with a title and body' do
    visit new_post_path
    fill_in 'Title', with: 'My First Post'
    fill_in 'Body', with: 'Well, when I first decided to start blogging...'
    click_on('Create Post')
    visit posts_path
    expect(page).to have_content('My First Post')
    expect(page).to have_content('Well, when I first')
  end
end
