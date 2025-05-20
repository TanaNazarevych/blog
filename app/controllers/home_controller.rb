class HomeController < ApplicationController
  # before_action :set_article, only: %i[ show  ]
  # before_action :authenticate_user!


  # GET /articles or /articles.json
  def index
    @articles = Article.order(:title).page(params[:page])

    @articles = @articles.search_by_article(params[:search]) if params[:search].present?
    
    @articles = @articles.tagged_with(params[:tag]) if params[:tag]

    @articles = @articles.search_by_category(params[:category]) if params[:category].present?
    
    # @articles = @articles.search_by_category_id(params[:category_id])

    @categories = Category.all.map { |category| [category.title, category.id] }
    @categories.prepend(["All categories", ""])

    #@categories = Category.search_by_category(params[:search  ]) if params[:search].present?

    # @tag = Tag.all
  end

  # GET /articles/1 or /articles/1.json
  def show
    @article = Article.friendly.find(params[:id])
    @user = User.find(@article.user_id)
    @comments = @article.comments
    @comment = Comment.new
    @comment.article_id = @article.id
    add_breadcrumb "Back to articles", :articles_path, class: "link-dark"
  end

end

 
