Rails.application.routes.draw do
  root "posts#index"

  namespace :api do
    namespace :v1 do
      
      resources :posts do
        resource :like, only: [:create, :destroy]
        get 'likes_count', to: 'likes#likes_count'
      end
      
      resources :users, only: [:show] do
        member do
          post 'follow', to: 'follows#follow'
          delete 'unfollow', to: 'follows#unfollow'
          get 'follows', to: 'follows#index'
        end

        collection do
          post 'login', to: 'authentication#login'
          post 'register', to: 'authentication#register'
        end
      end 
    end
  end
end