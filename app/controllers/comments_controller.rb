class CommentsController < ApplicationController
    before_action :authenticate_user!
    # before_action :set_comment

    
    def create
        @article = Article.friendly.find(params[:comment][:article_id])
        puts " ARTICLOSAFDsdfsdlvkjhsdiofsdiofsd #{@article}"
        @comment = Comment.new(comment_params)
        @comment.article  =  @article
        @comment.user = current_user
        
        if @comment.save!   
            redirect_to article_path(@article)
        else
            flash[:notice] = "Error saving comment!"
            redirect_to article_path(@article)
       
        end
    end

    private

    def set_comment
        # @comment = @article.comments.find(params[:id])
      end
  

  
    def comment_params
      params.require(:comment).permit(:body, :user, :article_id)
          
    end
end


