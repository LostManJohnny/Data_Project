Rails.application.routes.draw do

  root to: "home#index"

  get 'contact/index'
  get 'product/index'
  get 'product/show'

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

  get 'checkout/index'

  post 'products/add_to_cart/:id', to: 'products#add_to_cart', as: 'add_to_cart'
  post 'products/remove_qty_from_cart/:id', to: 'products#remove_qty_from_cart', as: 'remove_qty_from_cart'
  delete 'products/remove_from_cart/:id', to: 'products#remove_from_cart', as: 'remove_from_cart'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

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
