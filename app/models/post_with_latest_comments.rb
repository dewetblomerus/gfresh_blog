class PostWithLatestComments < SimpleDelegator
  def initialize(post, comments_by_post_id)
    super(post)
    @comments_by_post_id = comments_by_post_id
  end

  def latest_comments
    @comments_by_post_id[id] || []
  end
end
