Rails.application.routes.draw do
  resources :covid_questions
  resources :risks
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
  post "comment/:user_id" => "comments#create"
  get "long_trends_without_me/:user_id" => "long_trends#index_without_me"

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
      get "get_recommend/:user_id/" => "users#get_recommend"
      get "get_comment/:post_id/" => "users#get_comment"
      get "get_friend_recommend/:user_id" => "users#get_friend_recommend"
      post "create_new_hangout" => "users#create_new_hangout"
      get "current_get_participations" => "users#current_get_participations"
      get "get_participations/:id" => "users#get_participations"
      get "get_posts/:id" => "users#get_posts"
      get "get_post_user/:post_id" => "users#get_post_user"
    end
  end

  namespace :api do
    mount_devise_token_auth_for 'User', at: 'auth', controllers: {
      registrations: 'api/auth/registrations'
    }
  end
end
