class PagesController < ApplicationController
  before_action :set_comic

  def index
    @pages = (1..@comic.total_page).map do |page_number|
      @comic.pages.find_or_initialize_by(page_number: page_number)
    end
  end

  def create
    if params[:pages]
      params[:pages].each do |index, page_data|
        page = @comic.pages.find_or_initialize_by(id: page_data[:id])
        page.update(page_data.permit(:content, :page_number))
      end
    end

    redirect_to comic_pages_path(@comic), notice: "ページが更新されました！"
  end

  private

  def set_comic
    @comic = Comic.find(params[:comic_id])
  end
end