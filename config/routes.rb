Rails.application.routes.draw do
  devise_for :users
  resources :categories do
    resources :cards, except: [:show]
    # member do

    #   get 'cards/edit'
    #   patch 'cards/edit'
    #   delete 'cards/:card_id', to: 'cards#destroy'
    # end
    # only new, create, update, destroy
    # get 'cards/edit', on: :member
    # patch 'cards/edit', on: :member
    # resources :cards, only: [:edit, :update, :destroy]
  end
  # root "categories#index"

  # Study Categories
  get "study_categories/:id", to: "study_categories#study", as: "study_category"
  put "study_categories/:id/subscribe", to: "study_categories#subscribe", as: "subscribe_study_category"
  patch "study_categories/:id/archive", to: "study_categories#archive", as: "archive_study_category"
  delete "study_categories/:id", to: "study_categories#destroy", as: "destroy_study_category"
  # resources :study_categories, except: [:index, :new, :create, :edit, :update] do
  #   member do
  #     put :subscribe
  #     patch :archive
  #   end
  # end
  root "study_categories#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
