require 'rails_helper'

RSpec.describe Feed do
  it 'eager loads 3 recent comments to prevent n + 1' do
    post1 = FactoryGirl.create(:post)
    post2 = FactoryGirl.create(:post)
    FactoryGirl.create(:comment, authorable: post1)
    FactoryGirl.create(:comment, authorable: post1)
    FactoryGirl.create(:comment, authorable: post1)
    FactoryGirl.create(:comment, authorable: post1)
    FactoryGirl.create(:comment, authorable: post2)
    FactoryGirl.create(:comment, authorable: post2)
    FactoryGirl.create(:comment, authorable: post2)
    FactoryGirl.create(:comment, authorable: post2)

    # normal behaviour should make 3 queries N + 1
    expect do
      posts = Post.all
      posts.each do |post|
        post.comments.size
      end
    end.to make_database_queries(count: 3)

    # with feed object we make only 2
    expect do
      feed = Feed.new(
        authorables: Post.all,
        authorable_type: PostWithLatestComments
      )
      feed.posts.each do |post|
        post.latest_comments.size
      end
    end.to make_database_queries(count: 2)
  end
end
