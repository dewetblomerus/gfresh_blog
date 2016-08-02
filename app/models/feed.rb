class Feed
  def initialize(authorables: authorables, authorable_type: authorable_type)
    @authorables = authorables
    @authorable_type = authorable_type
    @comment_cache = build_comment_cache
  end

  def posts
    authorables
  end

  def articles
    authorables
  end

  def authorables
    @authorables.map { |authorable| @authorable_type.new(authorable, @comment_cache) }
  end

  private

  def comments
    Comment
      .select('*')
      .from(Arel.sql("(#{ranked_comments_query}) AS ranked_comments"))
      .where('comment_rank <= 3')
  end

  def ranked_comments_query
    Comment.where(authorable_id: @authorables.map(&:id)).select(<<-SQL).to_sql
      comments.*,
      dense_rank() OVER (
	PARTITION BY comments.authorable_id
	ORDER BY comments.created_at DESC
      ) AS comment_rank
    SQL
  end

  def build_comment_cache
    comments.group_by(&:authorable_id)
  end
end
