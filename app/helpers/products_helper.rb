module ProductsHelper
  def get_product_image(product)
    return get_card_image(product.card)
  end
end
