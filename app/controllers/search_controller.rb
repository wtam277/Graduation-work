class SearchController < ApplicationController
  def index
    keyword = params[:q]
    location = params[:location]

    # view（モーダル）からこのコントローラに直接 @comic は渡ってこないので、
    # params[:comic_id] から再取得する必要があります（ただし安全にやる）
    @comic = Comic.find(params[:comic_id]) if params[:comic_id].present?

    @results =
      case location
        when "story_map"
          if @comic
            @comic.story_maps.where("summary LIKE :kw OR description LIKE :kw", kw: "%#{keyword}%")
          else
            []
          end
        
        when "character"
          if @comic
            @comic.characters.where("name LIKE :kw OR description LIKE :kw", kw: "%#{keyword}%")
          else
            []
          end
      
      # case用の空白[]
      else
        []
      end

    render partial: "search/results", locals: { results: @results }
  end
end