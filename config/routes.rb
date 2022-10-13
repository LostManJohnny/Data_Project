Rails.application.routes.draw do
  root to: "home#index"

  get 'home/index'
  get 'cards/index'
  get 'cards/show'
  get 'cards/edit'
  get 'cards/destroy'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
