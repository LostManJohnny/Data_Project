class ProductsController < ApplicationController
  helper ProductsHelper
  skip_before_action :authenticate_user!

  def index
    @products = Product.order(id: :asc).page(params[:page]).per(8)
  end

  def show
    @product = Product.find(params[:id])
  end

  def to_s
    Product.find(params[:id]).card.name
  end

  def display_name
  end

  private
  def user_params
    params.require(:product).permit(:card_id, :stock, :price)
  end
end
