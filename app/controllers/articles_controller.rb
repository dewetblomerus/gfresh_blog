class ArticlesController < ApplicationController
  def new
    @article = Article.new
  end

  def create
    Article.create(article_params)
    redirect_to articles_path
  end

  def index
    @feed = Feed.new(authorables: Article.all, authorable_type: ArticleWithLatestComments)
  end

  def show
    @article = Article.find(params[:id])
    @comment = Comment.new(authorable: @article)
  end

  private

  def article_params
    params.require(:article).permit(:title, :body)
  end
end
