class ArticlesController < ApplicationController
  def new
    @article = Article.new
  end

  def create
    article = Article.create(article_params)
    redirect_to articles_path
  end

  def index
    @feed = Feed.new(articles: Article.all)
  end

  def show
    @article = Article.find(params[:id])
    @comment = Comment.new(article: @article)
  end

  private

  def article_params
    params.require(:article).permit(:title, :body)
  end
end
