class CardsController < ApplicationController
  def index
    @cards = Card.limit(50)
  end

  def show
    @card = Card.find(params[:id])
  end

  def edit
  end

  def destroy
  end
end
