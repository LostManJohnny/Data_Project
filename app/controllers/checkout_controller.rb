class CheckoutController < ApplicationController
  skip_before_action :authenticate_user!
  def index
    if !params[:province] || params[:province].blank?
      params[:province] = if current_user && current_user.present? && !current_user.province_id.nil?
                            current_user.province_id
                          else
                            1
                          end
    end

    @tax_p = update_tax
  end

  def success
    return if session[:ids].empty?

    cart_products = Product.find(session[:ids])
    cart_qty = session[:qty]

    ship_address = ""
    unless current_user.primary_address.nil?
      ship_address = Address.find(current_user.primary_address).to_s
    end

    order_total = 0

    cart_products.each_with_index do |product, index|
      order_total += (product.price * cart_qty[index])
    end

    province = 1
    province = params[:province] if params[:province]

    new_order = current_user.orders.create(
      status_id:        Status.find_by(code: "PEN-S").id,
      shipping_cost:    0,
      shipping_address: ship_address,
      taxes:            calculate_tax(province, order_total)
    )

    cart_products.each_with_index do |product, index|
      OrderItem.create(
        order_id:   new_order.id,
        quantity:   cart_qty[index],
        unit_price: product.price,
        product_id: product.id
      )

      product.update(
        stock: product.stock - cart_qty[index]
      )
    end

    session[:ids] = []
    session[:qty] = []
  end

  def show
    item_list = []

    session[:ids].each_with_index do |i, index|
      item = Product.find(i)
      item_list.append(
        {
          price_data: {
            currency:     "cad",
            unit_amount:  item.price.to_s.gsub(".", ""),
            product_data: {
              name: item.card.name
            },
            tax_behavior: "exclusive"
          },
          quantity:   session[:qty][index]
        }
      )
    end

    Stripe.api_key = "sk_test_51LyMLEDtE9pecSduWmaMpOdYbAThjy4Y3zcnwNWXTV1A06pqvzcsuWM44khZtXHUvQAseIgwPH9v6jNk5FAb8oU500iAKNPiwp"
    domain = "http://localhost:3000/"
    session = Stripe::Checkout::Session.create({
                                                 line_items:                  item_list,
                                                 mode:                        "payment",
                                                 success_url:                 "#{domain}success",
                                                 cancel_url:                  domain,
                                                 shipping_address_collection: { allowed_countries: ["CA"] },
                                                 automatic_tax:               { enabled: true }
                                               })

    redirect_to session.url, allow_other_host: true
  end

  private

  def update_tax
    province = Province.find(params[:province])

    province.hst + province.gst + province.pst
  end
end
