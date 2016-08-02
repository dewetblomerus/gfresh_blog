require 'rails_helper'

RSpec.describe Feed do
  it 'eager loads 3 recent comments to prevent n + 1' do
    post1 = FactoryGirl.create(:post)
    post2 = FactoryGirl.create(:post)
    comment1 = FactoryGirl.create(:comment, post: post1)
    comment2 = FactoryGirl.create(:comment, post: post1)
    comment3 = FactoryGirl.create(:comment, post: post1)
    comment4 = FactoryGirl.create(:comment, post: post1)
    comment5 = FactoryGirl.create(:comment, post: post2)
    comment6 = FactoryGirl.create(:comment, post: post2)
    comment7 = FactoryGirl.create(:comment, post: post2)
    comment8 = FactoryGirl.create(:comment, post: post2)

    # normal behaviour should make 3 queries N + 1
    expect do
      posts = Post.all
      posts.each do |post|
        post.comments.size
      end
    end.to make_database_queries(count: 3)

    # with feed object we make only 2
    expect do
      feed = Feed.new(posts: Post.all)
      feed.posts.each do |post|
        post.latest_comments.size
      end
    end.to make_database_queries(count: 2)
  end
end
