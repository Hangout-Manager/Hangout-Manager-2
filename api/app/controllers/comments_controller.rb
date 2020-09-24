class CommentsController < ApplicationController

  def create
    @user = User.find(params[:user_id])
    @comment = @user.comments.new(comment_params)
    @comment.save
  end

  private
  def comment_params
    params.permit(:content, :post_id)
  end
end
