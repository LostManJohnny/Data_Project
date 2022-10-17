class HomeController < ApplicationController
  def index
    @cards = Card.limit(10)

    @sets = CardSet.limit(10)
  end
end
