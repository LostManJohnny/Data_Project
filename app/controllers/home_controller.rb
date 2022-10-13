class HomeController < ApplicationController
  def index
    @cards = Cards.all
  end
end
