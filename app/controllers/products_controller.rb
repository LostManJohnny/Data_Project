class ProductsController < ApplicationController
  helper ProductsHelper

  def index
    @products = Product.order(id: :asc).page(params[:page])
  end

  def show
  end

  private
  def user_params
    params.require(:product).permit(:card_id, :stock, :price)
  end
end
