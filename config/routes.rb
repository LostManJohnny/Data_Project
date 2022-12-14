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

  get 'category/index'
  get 'category/show'

  get 'checkout/index', to:"checkout#index", as: "checkout_index"
  get "checkout", to: "checkout#show"
  get "success", to: "checkout#success", as: "success"
  get "cancel", to: "checkout#cancel", as: "cancel"

  get 'order_history', to:"orders#index", as: "order_history"
  get 'orders/show', to:"orders#show"
  get 'user/addresses', to: "user_profile#addresses", as: "user_addresses"

  get 'pages/:permalink' => "pages#permalink", as: 'permalink'

  post 'products/add_to_cart/:id', to: 'products#add_to_cart', as: 'add_to_cart'
  post 'products/remove_qty_from_cart/:id', to: 'products#remove_qty_from_cart', as: 'remove_qty_from_cart'
  delete 'products/remove_from_cart/:id', to: 'products#remove_from_cart', as: 'remove_from_cart'

  # Creating a route for the user to sign in.
  # devise_for :users
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

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
