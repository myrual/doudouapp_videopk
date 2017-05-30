Rails.application.routes.draw do
  resources :multivotes
  resources :streams do
    member do
      post :vote_for_left
      post :vote_for_right
      get :invitechallenge
    end
  end
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'battles#index'

  get 'about' => 'battles#about'

  get 'contact' => 'battles#contact'

  resources :battles do
    member do
      post :follow_left_video
      post :unfollow_left_video
      post :follow_right_video
      post :unfollow_right_video
      post :vote_for_left
      post :vote_for_right
      get :congratulation
      get :challengepreviewleft
      get :challengepreviewright
      
    end

    # resources :videos do
    #   resources :video_comments, only: [:new, :create]
    # end
    resources :battle_comments, only: [:new, :create]
  end

  namespace :admin do
    resources :videos do
      #resources :video_comments
    end
    resources :t1topics do
    end
    resources :battles do
      member do
        post :publish
        post :hidden
      end
      resources :battle_comments
    end
    
    resources :streams do
      member do
        post :approve
        post :rollback
        get :append
        get :reorder
        post :appended
        post :reordered
        get :addvideo
        post :addvideodone
        get :editvideo
        post :editvideodone
        
      end
    end

    resources :users
  end
  namespace :myasset do
    resources :videos do
      get :challenge
      post :createchallenge
      #resources :video_comments
    end

    resources :battles do
      resources :battle_comments
      get :challenge_left
      get :challenge_right
      post :createChallenge_left
      post :createChallenge_right
    end

    #resources :users
  end

  namespace :api do
    namespace :v1 do
      
      get 'upyunauths' => 'upyunauths#index'
      
      resources :streams
      resources :videos do
        member do
          post :new_ext_video
          post :video_convert_done
          post :thumb_done
        end
      end
      resources :battles do
        member do
          post :follow_left_video
          post :unfollow_left_video
          post :follow_right_video
          post :unfollow_right_video
        end

    # resources :videos do
    #   resources :video_comments, only: [:new, :create]
    # end
      resources :battle_comments, only: [:new, :create]
      end
    end
  end
end
