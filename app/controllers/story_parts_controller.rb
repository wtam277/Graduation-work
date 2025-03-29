class StoryPartsController < ApplicationController
  before_action :set_comic
  before_action :set_story_part, only: [:update]

  def index
    @story_parts = @comic.story_parts || []  # nilの可能性をなくす
    @story_part = @comic.story_parts.build
    @stiky_notes = @comic.stiky_notes.where(notable_type: "story_part")|| []

  end

  def create
    params[:story_part].each do |index, story_part_params|
      content = story_part_params[:content]
      part_type = story_part_params[:part_type].to_i
  
      next if content.blank?
  
      # すでに存在する場合は更新、それ以外は新規作成
      story_part = @comic.story_parts.find_or_initialize_by(part_type: part_type)
      story_part.update!(content: content)
    end
    redirect_to comic_story_parts_path(@comic), notice: "ストーリー部分を追加しました！"
    #redirect_to comic_story_parts_path(@comic), notice: "ストーリー部分を追加しました！"
  end

  def create_note
    note = @comic.stiky_notes.create!(
      notable_type: "story_part",
      note_content: params[:stiky_note][:note_content],
      position_x: params[:stiky_note][:position_x],
      position_y: params[:stiky_note][:position_y]
    )

    render json: note
  end

  def update_note
    note = @comic.stiky_notes.find_by(id: params[:id])
    if note.nil?
      render json: { error: "付箋が見つかりません" }, status: :not_found
      return
    end

  def destroy_note
    note = @comic.stiky_notes.find(params[:id])
    note.destroy!
    head :no_content
  end
  
    if note.update(stiky_note_params)
      render json: { id: note.id, note_content: note.note_content, position_x: note.position_x, position_y: note.position_y }
    else
      render json: { error: note.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    # 4つの固定されたフォーム（起・承・転・結）を処理
    (0..3).each do |i|
      story_part_params = params["story_part_#{i}"]
      next if story_part_params[:content].blank? # 空ならスキップ
  
      # すでに存在するストーリーパートを検索
      story_part = @comic.story_parts.find_or_initialize_by(part_type: story_part_params[:part_type])
  
      # データを更新
      story_part.update!(
        content: story_part_params[:content]
      )
    end
  
    # index にリダイレクト
    redirect_to comic_story_parts_path(@comic), notice: "ストーリー部分を更新しました！"
  end

  def destroy
  end

  private

  def set_comic
    @comic = Comic.find(params[:comic_id])
  end

  def story_part_params
    params.require(:story_part).permit(:content, :part_type)
  end

  def set_story_map
    @story_part = @comic.story_parts.last
  end

  def stiky_note_params
    params.require(:stiky_note).permit(:note_content, :position_x, :position_y)
  end
end