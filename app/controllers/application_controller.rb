class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :initalize_session
  before_action :load_cart
  before_action :configure_permitted_parameters, if: :devise_controller?

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
    session[:ids].delete_at(index)
    session[:qty].delete_at(index)

    redirect_to products_index_path
  end

  def remove_qty_from_cart
    id = params[:id].to_i

    if session[:ids].include?(id)
      index = session[:ids].index(id)
      session[:qty][index] -= 1

      if (session[:qty][index]).zero?
        session[:ids].delete_at(index)
        session[:qty].delete_at(index)
      end
    end

    redirect_to products_index_path
  end

  private

  def load_cart
    if session[:ids].present? && !session[:ids].empty?
      @cart_id = Product.find(session[:ids])
      @cart_quantity = session[:qty]
    else
      @cart_id = []
    end
  end

  def initalize_session
    session[:ids] ||= []
    session[:qty] ||= []
  end

  protected

  def configure_permitted_parameters
    attributes = %i[username province_id]
    devise_parameter_sanitizer.permit(:sign_up, keys: attributes)
    devise_parameter_sanitizer.permit(:account_update, keys: attributes)
  end

  def calculate_tax(province, total)
    prov = Province.find(province)
    (prov.gst * total) + (prov.hst * total) + (prov.pst * total)
  end
end
