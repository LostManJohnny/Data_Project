class ProductsController < ApplicationController
  def index
  end

  def show
  end

  private
  def user_params
    params.require(:product).permit(:card_id, :stock, :price)
  end
end
