class CheckoutController < ApplicationController
  def index
    @tax_p = update_tax()
  end

  private
  def update_tax
    province = params[:province]

    case province
    when 'MB'
      return 0.13

    when 'BC'
      return 0.12

    when 'AB'
      return 0.05

    when "NB"
      return 0.15

    when "NL"
      return 0.15

    when "NT"
      return 0.05

    when "NS"
      return 0.15

    when "NU"
      return 0.05

    when "ON"
      return 0.13

    when "PE"
      return 0.15

    when "QC"
      return 0.14975

    when "SK"
      return 0.11

    when "YK"
      return 0.05

    else
      return 0
    end
  end
end
