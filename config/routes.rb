Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'battles#index'

  resources :battles do
    member do
      post :follow_left_video
      post :unfollow_left_video
      post :follow_right_video
      post :unfollow_right_video
    end

    #resources :video_comments, only: [:new, :create]
    resources :videos do
      resources :video_comments, only: [:new, :create]
    end
  end

  namespace :admin do
    resources :videos do
      resources :video_comments
    end

    resources :battles
  end

end
