Rails.application.routes.draw do
  resources :user_profiles
  resources :relationships, only: [:create, :destroy]
  post "follow" => "relationships#create"
  post "unfollow" => "relationships#destroy"
  get "isfollow/:id" => "relationships#is_follow"

  namespace 'api' do
    namespace 'v1' do
      # resources :users
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
    end
  end

  namespace :api do
    mount_devise_token_auth_for 'User', at: 'auth', controllers: {
      registrations: 'api/auth/registrations'
    }
  end
end
