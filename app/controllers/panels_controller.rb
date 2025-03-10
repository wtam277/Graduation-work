class PanelsController < ApplicationController
    before_action :set_comic
    before_action :set_panel, only: [:update]

    def index
        @story_parts = @comic.story_parts || []  
        @story_part = @comic.story_parts.build
        @panels = @comic.panels || []  
        @panel = @comic.panels.last || @comic.panels.build 
        @characters = @comic.characters
    end

    def create
        @panel = @comic.panels.build(panel_params)
      
        if @panel.save
          # キャラクターを関連付ける
          @panel.characters = Character.where(id: params[:panel][:character_ids].reject(&:blank?))
      
          # セリフも保存
          params[:panel][:speech_contents].each_with_index do |content, index|
            character_id = params[:panel][:character_ids][index]
            Speech.create(panel: @panel, character_id: character_id, content: content) if character_id.present?
          end
      
          redirect_to comic_panels_path(@comic), notice: "パネルが作成されました！"
        else
          render :index, status: :unprocessable_entity
        end
      end

    
    def update
        if @panel.update(panel_params)
            redirect_to comic_panels_path(@comic), notice: "概要を更新しました！"
        else
             @panels = @comic.panels  
            render :index
    end
  end

    def set_comic
        @comic = Comic.find(params[:comic_id])
    end

    def set_story_part
        @story_part = StoryPart.find(params[:story_part_id])
      end

    def panel_params
        params.require(:panel).permit(:position, :location, character_ids: [])
    end

      def set_panel
        @panel = @comic.panels.find(params[:id]) # ← URLからパネルIDを取得して特定のものを更新
      end

end
