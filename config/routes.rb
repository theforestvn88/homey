Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  devise_for :users

  resources :projects do
    resources :comments, except: %i[ index ]
    member do
      get :load_more_comments
      get :edit_status
      patch :update_status
    end
    resources :assignments, except: %i[ index ]
  end

  root "projects#index"
end
