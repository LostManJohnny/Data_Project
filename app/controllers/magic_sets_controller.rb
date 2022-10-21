class MagicSetsController < ApplicationController
  def index
    @sets = MagicSet.order(id: :asc).page(params[:page])
  end

  def show
    @set = MagicSet.find(params[:id])
  end

  def search
    search_params = "%#{params[:keywords]}%"
    @cards = Card.where("name LIKE ?", search_params)
  end
end
