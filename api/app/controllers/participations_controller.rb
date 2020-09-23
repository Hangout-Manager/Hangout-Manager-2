class ParticipationsController < ApplicationController

  def create
    @user = User.find(user_params[:user_id])
    @user.participations.create(post_id: params[:post_id])
  end

  def destroy
    @user = User.find(user_params[:user_id])
    @participation = Participation.find_by(post_id: user_params[:post_id], user_id: @user)
    @participation.destroy
  end

  def is_participated
    @post = Post.find(params[:id])
    @is_participated = current_api_user.already_participated?(@post)
    render json: @is_participated
  end

  private
  def user_params
    params.permit(:user_id, :post_id)
  end

end
