class ApplicationController < ActionController::Base
  before_action :initalize_session
  before_action :load_cart

  private
  def load_cart
    if !session[:ids].blank? && !session[:ids].empty?
      @cart_id = Product.find(session[:ids])
      @cart_quantity = session[:qty]
    end
  end

  def initalize_session
    session[:ids] ||= []
    session[:qty] ||= []
  end
end
