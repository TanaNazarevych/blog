class ArticlesController < ApplicationController
  before_action :set_article, only: %i[ show edit update destroy ]

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
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles or /articles.json
  # def create
  #   article = Article.create! 
  #   params.require(:article).permit(:title, :content)
  #   redirect_to article
  # end

  #  debugger
def create
  @article = Article.new(article_params)

    respond_to do |format|
      if @article.save
        format.html { redirect_to article_url(@article), notice: "Article was successfully created." }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1 or /articles/1.json
  def update
   
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to article_url(@article), notice: "Article was successfully updated." }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1 or /articles/1.json
  def destroy
    @article.destroy

    respond_to do |format|
      format.html { redirect_to articles_url, notice: "Article was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
  
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
     
      
    end

    # Only allow a list of trusted parameters through.
    def article_params
      params.fetch(:article, {})
      params.require(:article).permit(:title, :text, :category_id, :tags_as_string, :image, :search)
    end
  end

 
