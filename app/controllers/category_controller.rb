class CategoryController < ApplicationController
  def index
    @categories = Type.all
  end

  def show
    @cards = Type.find(params[:type]).cards.page(params[:page]).per(8)

  end
end
