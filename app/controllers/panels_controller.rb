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

  def new
    @comic = Comic.find(params[:comic_id])
    @panel = @comic.panels.find_by(position: params[:position]) || @comic.panels.build(position: params[:position])
    @characters = @comic.characters
    2.times { @panel.speeches.build } if @panel.speeches.empty?
  end

  def create
    @comic = Comic.find(params[:comic_id])
    
    # `position` ごとの `Panel` を 1 つしか作らないようにする
    existing_panel = @comic.panels.find_by(position: panel_params[:position])
    
    if existing_panel
      redirect_to new_comic_panel_path(@comic, position: panel_params[:position]), alert: "このポジションにはすでにパネルが存在します。"
      return
    end
    
    # `Panel` を作成
    @panel = @comic.panels.create(panel_params)
    
    if @panel.persisted? # 🎯 `save` の代わりに `create` を使うことで保存確認
      # 🎯 Location を手動で保存する
      if params[:panel][:locations].present?
        Array.wrap(params[:panel][:locations]).each do |location_params|
          @panel.locations.create!(location_name: location_params[:location_name])
        end
      end
    
      # 🎯 セリフを保存する
      if params[:panel][:speeches].present?
        Array.wrap(params[:panel][:speeches]).each_with_index do |speech_params, index|
          @panel.speeches.create!(
            character_id: speech_params[:character_id],
            content: speech_params[:content],
            position: speech_params[:position] || index + 1 # 🔥 `position` を設定
          )
        end
      end
    
      redirect_to comic_panel_path(@comic, @panel), notice: "パネルが作成されました！"
    else
      @characters = @comic.characters # エラー時のためにキャラクターリストを取得
      render :new, status: :unprocessable_entity
    end
  end
  
  def edit
    @panel = @comic.panels.find(params[:id])
    @characters = @comic.characters
    @panel.speeches.build while @panel.speeches.size < 2
    @panel.locations.build if @panel.locations.empty?
  end


  def update
    if @panel.update(panel_params)
      redirect_to comic_panels_path(@comic), notice: "パネルを更新しました！"
    else
      @characters = @comic.characters
      render :edit, status: :unprocessable_entity
    end
  end

  def set_comic
    @comic = Comic.find(params[:comic_id])
  end

  def set_story_part
    @story_part = StoryPart.find(params[:story_part_id])
  end

  def set_panel
    @panel = @comic.panels.find(params[:id]) # ← URLからパネルIDを取得して特定のものを更新
  end

  def panel_params
    params.require(:panel).permit(
      :position,
      locations_attributes: [:location_name],
      speeches_attributes: [:character_id, :content, :position] # 🔥 `position` を追加
    )
  end
end