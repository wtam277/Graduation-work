Rails.application.routes.draw do
  get "search/index"
  get "relationship_groups/index"
  resources :works
  resource :user, only: [:edit, :update]

  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  root "home#index"
  get "/works", to: "works#index"

  resources :comics, controller: "works" do

    collection do
      get :search, to: "search#index", as: :search
    end

    resources :story_maps, only: [:index, :create, :update] 
    resources :story_parts, only: [:index, :create, :update, :destroy] 
    resources :characters, only: [:index, :new, :create, :update, :edit, :destroy]
    resources :panels, only: [:index, :new, :create, :update, :edit] 
    resources :relationship_groups, only: [:index, :new, :create, :update, :edit, :destroy]
    resources :pages, only: [:index, :create, :update]
      # stiky_notes (story_part 用)
    post   "story_parts/stiky_notes",      to: "story_parts#create_note"
    patch  "story_parts/stiky_notes/:id",  to: "story_parts#update_note"
    delete "story_parts/stiky_notes/:id",  to: "story_parts#destroy_note"

    # stiky_notes (panel 用)
    post   "panels/stiky_notes",           to: "panels#create_note"
    patch  "panels/stiky_notes/:id",       to: "panels#update_note"
    delete "panels/stiky_notes/:id",       to: "panels#destroy_note"
  end


  resources :story_maps, only: [:index, :create, :update]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"
end
