class OrdersController < ApplicationController
  def index
    @orders = current_user.orders.page(params[:page]).per(5)
  end

  def show
    order = Order.find(params[:format])
    return unless order.user == current_user

    @order = order
  end
end
