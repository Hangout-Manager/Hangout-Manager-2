require 'net/http'
require 'json'

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

  def current_get_long_trend
    @current_long_trend = current_api_user.long_trend
    render json: { data: @current_long_trend }
  end

  def get_long_trend
    @user = User.find(params[:user_id])
    @long_trend = @user.long_trend
    render json: @long_trend 
  end

  def get_answer
    @user = User.find(params[:user_id])
    @answer = @user.questions.order(created_at: :desc).limit(1)
    render json: @answer
  end

  def get_user_long_trend 
    @user = User.find(params[:user_id])
    @get_user_long_trend = @user.long_trend
    render json: @get_user_long_trend
  end

  def get_participated_users
    @post = Post.find(params[:post_id])
    @get_participated_users = @post.participated_users
    render json: @get_participated_users
  end

  def get_recommend
    uri = URI.parse("http://recommend:5000/hangouts/#{params[:user_id]}")
    json = Net::HTTP.get(uri)
    @recommend = JSON.parse(json)
    render json: @recommend
  end

  def get_comment
    @post = Post.find(params[:post_id])
    @comment = @post.comments
    render json: @comment
  end

  def get_friend_recommend
    uri = URI.parse("http://recommend:5000/friends/#{params[:user_id]}")
    json = Net::HTTP.get(uri)
    @recommend_friends = JSON.parse(json)
    render json: @recommend_friends
  end

  def create_new_hangout
    @user = User.find(new_hangout_params[:user_id])
    @q1 = new_hangout_params[:q1]
    @q2 = new_hangout_params[:q2]
    @q3 = new_hangout_params[:q3]
    @q4 = new_hangout_params[:q4]
    @q5 = new_hangout_params[:q5]
    p ("@q1")
    p (@q1)
    p ("@q2")
    p (@q2)
    p ("@q3")
    p (@q3)
    p ("@q4")
    p (@q4)
    p ("@q5")
    p (@q5)
    p ("@user")
    p (@user)
    @long_trend = @user.long_trend
    p ("@long_trend")
    p (@long_trend)
  end

 private
    def user_params
      params.permit(:user_id)
    end

    def new_hangout_params
      params.permit(:name, :q1, :q2, :q3, :q4, :q5, :user_id)
    end
end
