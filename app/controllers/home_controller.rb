class HomeController < ApplicationController
  def index
    @cards = Card.limit(10)

    @sets = MagicSet.limit(10)
  end
end
