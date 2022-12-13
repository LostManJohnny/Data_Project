module ProductsHelper
  def get_product_image(product)
    get_card_image(product.card)
  end
end
