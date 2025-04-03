class RelationshipGroupsController < ApplicationController
  before_action :set_comic

  def index
    @characters = @comic.characters
    @relationship_group = @comic.relationship_groups.build
    @relationship_group.relationships.build
    @relationship_groups = @comic.relationship_groups.includes(:relationships)
  end

  def new
    @characters = @comic.characters
    @relationship_group = @comic.relationship_groups.build
    @relationship_group.relationships.build if @relationship_group.relationships.empty?
    @relationship_groups = @comic.relationship_groups.includes(:relationships)
  end
  
  def create
    @characters = @comic.characters # 追加: ビューで使えるようにセット
    @relationship_group = @comic.relationship_groups.build(relationship_group_params)
    logger.debug "💡 relationship_group_params: #{relationship_group_params.inspect}"
    
    if @relationship_group.save
      redirect_to comic_characters_path(@comic), notice: "相関図を作成しました！"
    else
      @characters = @comic.characters
      render :new
    end
  end

  def edit
    @characters = @comic.characters
    @relationship_group = @comic.relationship_groups.find(params[:id])
  end
  
  def update
    @relationship_group = @comic.relationship_groups.find(params[:id])
    if @relationship_group.update(relationship_group_params)
      redirect_to comic_characters_path(@comic), notice: "相関図を更新しました！"
    else
      @characters = @comic.characters
      render :edit
    end
  end

    def destroy
      @relationship_group = @comic.relationship_groups.find(params[:id])
      @relationship_group.destroy
      redirect_to comic_characters_path(@comic), notice: "相関図が削除されました！"
    end

  private

  def set_comic
    @comic = Comic.find(params[:comic_id])
  end

  def relationship_group_params
    params.require(:relationship_group).permit(
      :group_name,
      relationships_attributes: [
        :id,
        :character_a_id,
        :character_b_id,
        :relationship_type,
        :directionality,
        :_destroy
      ]
    )
  end
  
end