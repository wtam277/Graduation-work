class PanelsController < ApplicationController
  before_action :set_comic
  before_action :set_panel, only: [:update]

  def index
    @story_parts = @comic.story_parts || []  
    @story_part = @comic.story_parts.build
    @panels = @comic.panels || []  
    @panel = @comic.panels.last || @comic.panels.build 
    @characters = @comic.characters
    @stiky_notes = @comic.stiky_notes.where(notable_type: "panel")|| []
  end

  def new
    @comic = Comic.find(params[:comic_id])
    @panel = @comic.panels.find_by(position: params[:position]) || @comic.panels.build(position: params[:position])
    @characters = @comic.characters
    2.times { @panel.speeches.build } if @panel.speeches.empty?
  end

  def create
    @comic = Comic.find(params[:comic_id])
    
    existing_panel = @comic.panels.find_by(position: panel_params[:position])
    if existing_panel
      redirect_to new_comic_panel_path(@comic, position: panel_params[:position]), alert: "このポジションにはすでにパネルが存在します。"
      return
    end
  
    @panel = @comic.panels.new(panel_params)
  
    if @panel.save
      flash[:notice] = "パネルが作成されました！"
      redirect_to comic_panel_path(@comic, @panel)
    else
      flash[:alert] = " 保存失敗: #{@panel.errors.full_messages.join(', ')}"  # エラーメッセージを flash[:alert] にセット
      @characters = @comic.characters
      render :index, status: :unprocessable_entity
    end
  end
  
  def edit
    @comic = Comic.find(params[:comic_id])
    @panel = @comic.panels.find(params[:id]) # ✅ Panel を取得
    @characters = @comic.characters
    @panel.speeches.build if @panel.speeches.empty? # 編集時に speech フォームが空にならないように
  end

  def update
    if @panel.update(panel_params)
      redirect_to comic_panels_path(@comic), notice: "概要を更新しました！"
    else
      @panels = @comic.panels  
      render :index
    end
  end

  def create_note
    note = @comic.stiky_notes.create!(
      notable_type: "panel",
      note_content: params[:stiky_note][:note_content],
      position_x: params[:stiky_note][:position_x],
      position_y: params[:stiky_note][:position_y]
    )

    render json: note
  end

  def update_note
    note = @comic.stiky_notes.find_by(id: params[:id])
    if note.update(stiky_note_params)
      render json: { id: note.id, note_content: note.note_content, position_x: note.position_x, position_y: note.position_y }
    else
      render json: { error: note.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy_note
    note = @comic.stiky_notes.find(params[:id])
    note.destroy!
    head :no_content
  end

  private

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
      locations_attributes: [:id, :location_name, :_destroy],
      speeches_attributes: [:id, :character_id, :content, :position, :_destroy] # 🔥 id と _destroy を追加
    )
  end
  
  def stiky_note_params
    params.require(:stiky_note).permit(:note_content, :position_x, :position_y)
  end
end