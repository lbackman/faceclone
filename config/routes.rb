Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # creating routes for user posts
  # https://stackoverflow.com/questions/31757006/rails-4-how-do-i-add-an-index-route-for-a-nested-resource-in-order-to-list-al
  
  resources :users, except: [:new, :create] do
    resources :friend_requests, only: :index
    resources :posts, except: :index
    member do
      delete :purge_avatar
      get :friends
    end
  end

  resources :posts, only: :index do
    resources :comments, module: :posts
  end

  resources :comments

  resources :friend_requests, only: [:create, :update, :destroy]

  resources :likes, only: [:create, :destroy]
  get 'posts/:id/likes', to: 'likes#index', as: :post_likes
  get 'posts/:post_id/comments/:id/likes', to: 'likes#index', as: :comment_likes

  # Defines the root path route ("/")
  authenticated :user do
    root to: "posts#index"
  end

  devise_scope :user do
    root to: "devise/sessions#new", as: :unauthenticated_root
  end
end
