ActiveAdmin.register Card do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :artist_id, :ascii_name, :border_color, :color_identity, :colors, :cmc, :finishes, :flavor_name, :flavor_text, :has_foil, :is_alternative, :is_fullart, :is_oversized, :is_promo, :is_reprint, :is_reserved, :layout, :life, :loyalty, :mana_cost, :name, :original_printing, :power, :toughness, :rarity, :scryfallid, :magic_set_id, :card_text
  #
  # or
  #
  # permit_params do
  #   permitted = [:artist_id, :ascii_name, :border_color, :color_identity, :colors, :cmc, :finishes, :flavor_name, :flavor_text, :has_foil, :is_alternative, :is_fullart, :is_oversized, :is_promo, :is_reprint, :is_reserved, :layout, :life, :loyalty, :mana_cost, :name, :original_printing, :power, :toughness, :rarity, :scryfallid, :magic_set_id, :card_text]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

end
