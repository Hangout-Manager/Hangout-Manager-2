class Api::V1::UsersController < ApplicationController
  # before_action :authenticate_api_user!

  def index
    @users = User.all
    render json: { status: 'SUCCESS', message: 'Loaded users', data: @users }
  end
  
  def show
    @user = current_api_user
    render json: { data: @user }
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
end
