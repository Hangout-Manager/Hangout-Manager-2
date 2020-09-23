Rails.application.routes.draw do
  resources :questions
  resources :long_trends
  resources :hangouts
  resources :posts
  resources :user_profiles
  resources :relationships, only: [:create, :destroy]
  post "follow" => "relationships#create"
  post "unfollow" => "relationships#destroy"
  post "participate" => "participations#create"
  post "unparticipate" => "participations#destroy"
  get "isfollow/:id" => "relationships#is_follow"
  get "isparticipated/:id" => "participations#is_participated"
  get "hangouts10" => "hangouts#index10"

  namespace 'api' do
    namespace 'v1' do
      get "index" => "users#index"
      get "show" => "users#show"
      get "profile" => "users#profile"
      get "get_user/:id" => "users#get_user"
      get "get_all_users" => "users#get_all_users"
      get "current_get_followings" => "users#current_get_followings"
      get "get_followings/:id" => "users#get_followings"
      get "current_get_followers" => "users#current_get_followers"
      get "get_followers/:id" => "users#get_followers"
      get "is_login" => "users#is_login"
      get "current_get_posts" => "users#current_get_post"
      get "current_get_long_trend" => "users#current_get_long_trend"
      get "get_long_trend/:user_id" => "users#get_long_trend"
      get "get_answer/:user_id" => "users#get_answer"
      get "get_user_long_trend/:user_id" => "users#get_user_long_trend"
      get "get_participated_users/:post_id" => "users#get_participated_users"
    end
  end

  namespace :api do
    mount_devise_token_auth_for 'User', at: 'auth', controllers: {
      registrations: 'api/auth/registrations'
    }
  end
end
