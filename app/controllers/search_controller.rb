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

        when "story_part"
          if @comic
            @comic.story_parts.where("content LIKE :kw", kw: "%#{keyword}%")
          else
            []
          end
        
        when "character"
          if @comic
            @comic.characters.where("name LIKE :kw OR description LIKE :kw", kw: "%#{keyword}%")
          else
            []
          end
          
        #when "relationship_group"
          #if @comic
            #@comic.relationship_groups.where("name LIKE :kw OR description LIKE :kw", kw: "%#{keyword}%")
          #else
            #[]
          #end
        
        when "panel"
          #panel の中の speech の content を取り出したいので、speechesをjoinする
          if @comic
            @comic.panels
            .joins(:speeches)
            .where("speeches.content LIKE :kw", kw: "%#{keyword}%")
          end

        when "page"
          if @comic
            @comic.pages.where("content LIKE :kw", kw: "%#{keyword}%")
          else
            []
          end
        
        when "stiky_note_story_part"
          if @comic
            @comic.stiky_notes.where(notable_type: "story_part").where("note_content LIKE :kw", kw: "%#{keyword}%") 
          else
            []
          end

        when "stiky_note_panel"
          if @comic
            @comic.stiky_notes.where(notable_type: "panel").where("note_content LIKE :kw", kw: "%#{keyword}%")
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