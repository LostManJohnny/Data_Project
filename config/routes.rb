Rails.application.routes.draw do
  get 'contact/index'
  get 'product/index'
  get 'product/show'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root to: "home#index"

  get 'home/index'
  get 'about/index'
  get 'contact/index'

  get 'cards/index'
  get 'cards/show'
  get 'cards/edit'
  get 'cards/destroy'

  get 'magic_sets/index'
  get 'magic_sets/show'

  get 'artists/index'
  get 'artists/show'

  get 'products/index'
  get 'products/show'

  resources :cards, only: [:index, :show] do
    collection do
      get "search"
    end
  end

  resources :magic_sets, only: [:index, :show] do
    collection do
      get "search"
    end
  end

  resources :artists, only: [:index, :show]
end
