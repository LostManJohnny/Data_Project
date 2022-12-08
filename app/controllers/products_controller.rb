class ProductsController < ApplicationController
  helper ProductsHelper

  def index
    @products = Product.order(id: :asc).page(params[:page])
  end

  def show
    @product = Product.find(params[:id])
  end

  def add_to_cart
    id = params[:id].to_i

    if session[:ids].include?(id)
      index = session[:ids].index(id)
      session[:qty][index] += 1
    else
      session[:ids] << id
      session[:qty] << 1
    end

    redirect_to products_index_path
  end

  def remove_from_cart
    id = params[:id].to_i

    index = session[:ids].index(id)
    session[:id].delete_at(index)
    session[:qty].delete_at(index)
  end

  def remove_qty_from_cart
    id = params[:id].to_i

    if session[:ids].include?(id)
      index = session[:ids].index(id)
      session[:qty][index] -= 1

      if session[:qty][index] == 0
        session[:id].delete_at(index)
        session[:qty].delete_at(index)
      end
    end
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
