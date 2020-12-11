Rails.application.routes.draw do

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'sign_up' => "users#sign_up"
  post 'users/create' => "users#create"
  get "login_form" => "users#login_form"
  post "login" => "users#login"
  get "users/index" => "users#index"
  post "logout" => "users#logout"
  get "users/feed" => "users#feed"
  get "users/:id" => "users#show"
  get "users/:id/edit" => "users#edit",:as => :user
  get "users/:id/profile" => "users#profile"
  post "users/update" => "users#update"
  post "users/:id/update_profile" => "users#update_profile"
  get "users/:id/show_following" => "users#show_following"
  get "users/:id/show_follower" => "users#show_follower"


  resources :users do
    member do
      get :following, :followers
    end
  end

  get "posts/index" => "posts#index"
  get "posts/create" => "posts#create"
  post "posts/new_post" => "posts#new_post"
  delete  "posts/:id/destroy" => "posts#destroy"

  get "top" => "home#top"

 resources :relationships, only: [:create, :destroy]

end
