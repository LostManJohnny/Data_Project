require("http")
require("json")

class CardsController < ApplicationController
  helper CardsHelper

  def index
    @cards = Card.order(id: :asc).page(params[:page])
  end

  def show
    @card = Card.find(params[:id])

    req_url = "https://api.scryfall.com/cards/#{@card.scryfallid}"

    data = HTTP.get(req_url).to_s

    @json_data = JSON.parse(data)

    @image_uri = @json_data["image_uris"]["small"]

    @scryfall_link = @json_data["scryfall_uri"]
  end

  def search
    search_params = "%#{params[:keywords]}%"

    if params[:type].blank? && params[:keywords].blank?
      redirect_to root_path and return
    elsif params[:type].blank?
      @cards = Card.where("lower(name) LIKE ? OR lower(card_text) LIKE ?", search_params,
                          search_params).page(params[:page])
    elsif params[:keywords].blank?
      @cards = Card.joins(:types)
                   .where(types: { id: params[:type] })
                   .page(params[:page])
    else
      @cards = Card.joins(:types)
                   .where(types: { id: params[:type] })
                   .where("lower(Cards.name) LIKE ? OR lower(card_text) LIKE ?", search_params, search_params)
                   .page(params[:page])
    end
  end

  def edit; end

  def destroy; end
end
