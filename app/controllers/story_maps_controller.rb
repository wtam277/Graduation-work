class StoryMapsController < ApplicationController
  before_action :set_comic
  before_action :set_story_map, only: [:update]

  def index
    @story_map = @comic.story_maps.last || @comic.story_maps.build
  end

  def create
    @story_map = @comic.story_maps.build(story_map_params)
    if @story_map.save
      redirect_to comic_story_maps_path(@comic), notice: "概要を追加しました！"
    else
      render :index
    end
  end

  def update
    if @story_map.update(story_map_params)
      redirect_to comic_story_maps_path(@comic), notice: "概要を更新しました！"
    else
      render :index
    end
  end

  private

  def story_map_params
    params.require(:story_map).permit(:summary, :description)
  end

  def set_comic
    @comic = Comic.find(params[:comic_id])
  end

  def set_story_map
    @story_map = @comic.story_maps.last
  end
end