class HomeController < ApplicationController
  skip_before_action :authenticate_user!
  def index
    @cards = Card.order("RANDOM()").first(10)

    @ticket_items = Product.order(price: :desc).limit(10)

    @products = Product.order("RANDOM()").first(10)
  end
end
