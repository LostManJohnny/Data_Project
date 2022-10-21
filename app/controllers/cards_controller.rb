require("http")
require("json")

class CardsController < ApplicationController
  def index
    @cards = Card.order(id: :asc).page(params[:page])
  end

  def show
    @card = Card.find(params[:id])

    req_url = "https://api.scryfall.com/cards/" + @card.scryfallid

    data = HTTP.get(req_url).to_s

    @json_data = JSON.parse(data)

    @image_uri = @json_data['image_uris']['small']

    @scryfall_link = @json_data['scryfall_uri']

  end

  def search
    search_params = "%#{params[:keywords]}%"
    @cards = Card.where("name LIKE ?", search_params).page(params[:page])
  end

  def edit
  end

  def destroy
  end
end
