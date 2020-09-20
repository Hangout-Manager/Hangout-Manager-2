class RelationshipsController < ApplicationController

  def create
    @follow = User.find(user_params[:follow_id])
    @user = User.find(user_params[:user_id])
    @user.follow(@follow)
  end

  def destroy
    @target = User.find(params[:follow_id])
    @user = User.find(user_params[:user_id])
    @user.unfollow(@target)
  end

  def is_follow
    @target = User.find(params[:id])
    @is_follow = current_api_user.following?(@target)
    render json: { data: !(@is_follow) }
  end

 private
    def user_params
      params.permit(:user_id, :follow_id)
    end

end
