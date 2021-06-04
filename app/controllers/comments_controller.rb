class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
     if @comment.save
      redirect_to prototype_path(@comment.prototype)
       
     else
      @prototype = @comment.prototype
      @commnets = @prototype.comments
       render "prototypes/show"
     end
  end

def show
  @comment =Comment.new
  @comments = @prototype.comments.include(:user)
end

private
def comment_params
  params.require(:comment).permit(:text).merge(user_id: current_user.id, prototype_id: params[:prototype_id])
end

end

