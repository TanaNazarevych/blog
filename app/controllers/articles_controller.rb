class ArticlesController < ApplicationController
  
  before_action :set_article, only: [:edit, :update, :destroy, :show]
  before_action :authenticate_user!
 

  # GET /articles or /articles.json
  def index
  @articles = Article.order(:title).page(params[:page])

  # Apply filters
  @articles = @articles.search_by_article(params[:search]) if params[:search].present?
  @articles = @articles.tagged_with(params[:tag]) if params[:tag].present?
  @articles = @articles.search_by_category(params[:category]) if params[:category].present?

  # Load all categories and prepend the "All categories" option
  @categories = Category.all.map { |category| [category.title, category.id] }
  @categories.prepend(["All categories", ""])
end



  # GET /articles/1 or /articles/1.json
  def show
    # @article = Article.new(article_params)
    
      @user = User.find(@article.user_id)
      @comments = @article.comments
      @comment = Comment.new
      @comment.article_id = @article.id
      add_breadcrumb "Back to articles", :articles_path, class: "link-dark"

  end

  # GET /articles/new
  def new
    @article = Article.new
    add_breadcrumb "Back to articles", :articles_path, class: "link-dark"
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
  # @article.picture.attach(params[:article][:picture])
  # @article.user_id = @user.id
  # @article.image.attach(params[:article][:image])
  # uploader = imageUploader.new
  # uploader.store!(my_file)

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
    # @article = Article.destroy(params[:id])
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: "Article was successfully deleted." }
      format.json { head :no_content }
    end
  end

  private
  
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.friendly.find(params[:id])  
    end


    def article_params
      params.fetch(:article, {})
      params.require(:article).permit(:title, :text, :search, :category_id, :image, :tags_as_string)
            .merge(user: current_user)
    end
    
 
    
  end

 
