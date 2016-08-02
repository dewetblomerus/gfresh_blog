class ArticleWithLatestComments < SimpleDelegator
  def initialize(article, comments_by_article_id)
    super(article)
    @comments_by_article_id = comments_by_article_id
  end

  def latest_comments
    @comments_by_article_id[id] || []
  end
end
