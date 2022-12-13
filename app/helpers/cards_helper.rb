module CardsHelper
  def get_card_image(card)
    req_url = "https://api.scryfall.com/cards/#{card.scryfallid}"
    data = HTTP.get(req_url).to_s
    json_data = JSON.parse(data)
    json_data["image_uris"]["small"]
  end
end
