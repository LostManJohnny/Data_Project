class PagesController < ApplicationController
  skip_before_action :authenticate_user!
  # GET /pages/1 or /pages/1.json
  def permalink
    @page = Page.find_by(permalink: params[:permalink])
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_page
    @page = Page.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def page_params
    params.require(:page).permit(:title, :content, :permalink)
  end
end
