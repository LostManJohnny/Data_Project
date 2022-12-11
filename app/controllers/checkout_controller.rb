class CheckoutController < ApplicationController
  skip_before_action :authenticate_user!
  def index

    if !params[:province] || params[:province].blank?
      if current_user && !current_user.blank? && !current_user.province_id.nil?
        params[:province] = current_user.province_id
      else
        params[:province] = 0
      end
    end

    @tax_p = update_tax()
  end

  def show
    item_list = []

    session[:ids].each_with_index do |i, index|
      item = Product.find(i)
      item_list.append(
      {
        price_data: {
          currency: 'cad',
          unit_amount: item.price.to_s.gsub(".",""),
          product_data: {
            name: item.card.name,
          },
          tax_behavior: 'exclusive',
        },
        quantity: session[:qty][index]
      })
    end

    Stripe.api_key = "sk_test_51LyMLEDtE9pecSduWmaMpOdYbAThjy4Y3zcnwNWXTV1A06pqvzcsuWM44khZtXHUvQAseIgwPH9v6jNk5FAb8oU500iAKNPiwp"
    domain = "http://localhost:3000/"
    session = Stripe::Checkout::Session.create({
      line_items: item_list,
      mode: 'payment',
      success_url: domain + 'success',
      cancel_url: domain,
      shipping_address_collection: {allowed_countries: ['CA']},
      automatic_tax: {enabled: true},
    })

    redirect_to session.url, allow_other_host: true
  end

  private
  def update_tax
    province = Province.find(params[:province])

    return province.hst + province.gst + province.pst
  end
end