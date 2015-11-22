Rails.application.routes.draw do
  resources :labels, only: [:show]

  resources :topics do
    resources :posts, except: [:index]
  end

  resources :posts, only: [] do
    resources :comments, only: [:create, :destroy]
    resources :favorites, only: [:create, :destroy]
    post '/up-vote' => 'votes#up_vote', as: :up_vote
    post '/down-vote' => 'votes#down_vote', as: :down_vote
  end

  resources :users, only: [:new, :create, :show]
  resources :sessions, only: [:new, :create, :destroy]

  get 'about' => 'welcome#about'

  root to: 'welcome#index'

  namespace :api do
    namespace :v1 do
      # resources :users, only: [:index,:show]
# Old
      # resources :topics, except: [:edit,:new]
# New
      resources :topics, except: [:edit,:new] do
# TODO Change to use #create_post from Topics controller
        # resources :posts, only: [:destroy,:create,:update]
        # resources :posts, only: [:destroy,:update]
        # resources :posts
      end

      resources :posts, except: [:create]

      resources :users, only: [:index, :show, :create, :update]
    end
  end
end
