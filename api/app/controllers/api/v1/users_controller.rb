class Api::V1::UsersController < ApplicationController
  # before_action :authenticate_api_user!

  def index
    @users = User.all
    render json: { data: @users }
  end
  
  def show
    @user = current_api_user
    render json: { data: @user }
  end

  def get_user
    @target_user = User.find(params[:id])
    @target_user_age = User.find(params[:id]).user_profile.age
    @target_user_sex = User.find(params[:id]).user_profile.sex.name
    @target_user_place = User.find(params[:id]).user_profile.place.name
    user_profile = {
      user: @target_user,
      age: @target_user_age,
      sex: @target_user_sex,
      place: @target_user_place
    }
    render json: { data: user_profile }
  end

  def profile
    @age = current_api_user.user_profile.age
    @sex = current_api_user.user_profile.sex.name
    @place = current_api_user.user_profile.place.name
    profile = {
      age: @age,
      sex: @sex,
      place: @place
    }
    render json: { data: profile }
  end

  def current_get_followings
    @followings = current_api_user.followings
    render json: { data: @followings }
  end

  def current_get_followings
    @current_followings = current_api_user.followings
    render json: { data: @current_followings }
  end

  def get_followings
    @target_user = User.find(params[:id])
    @followings = @target_user.followings
    render json: { data: @followings }
  end

  def current_get_followers
    @current_followers = current_api_user.followers
    render json: { data: @current_followers }
  end

  def get_followers
    @target_user = User.find(params[:id])
    @followers = @target_user.followers
    render json: { data: @followers }
  end

  def is_login
    @is_login = api_user_signed_in?
    render json: { data: @is_login }
  end

  def current_get_post
    @current_posts = current_api_user.posts
    render json: { data: @current_posts }
  end

 private
    def user_params
      params.permit(:user_id)
    end

end
