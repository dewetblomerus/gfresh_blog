require 'rails_helper'

RSpec.describe 'adding posts' do
  it 'allows a user to create a prost with a title and body' do
    visit root_path
    click_on('New Post')
    fill_in 'Title', with: 'My First Post'
    fill_in 'Body', with: 'Well, when I first decided to start blogging...'
    click_on('Create Post')
    visit posts_path
    expect(page).to have_content('My First Post')
    expect(page).to have_content('Well, when I first')
  end

  it 'allows a user to use tags that gets parsed' do
    visit root_path
    click_on('New Post')
    fill_in 'Title', with: 'My First Post'
    fill_in 'Body', with: '#am totally #tagging every #this bit of this #up'
    click_on('Create Post')
    click_on('My First Post')
    expect(page).to have_content('#am #tagging #this')
  end
end
