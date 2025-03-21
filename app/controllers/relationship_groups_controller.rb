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
    puts "Received params: #{params.inspect}" # 追加
    
    if @relationship_group.save
      redirect_to comic_relationship_groups_path(@comic), notice: "相関図を作成しました！"
    else
      @relationship_groups = @comic.relationship_groups.includes(:relationships) # 追加
      render :index
    end
  end

  def edit
  end

  def destroy
    @relationship_group = @comic.relationship_groups.find(params[:id])
  
    # 関連する relationships を削除
    @relationship_group.relationships.destroy_all
  
    # relationship_group を削除
    @relationship_group.destroy
  
    redirect_to comic_relationship_groups_path(@comic), notice: "相関図が削除されました！"
  end

  private

  def set_comic
    @comic = Comic.find(params[:comic_id])
  end

  def relationship_group_params
    params.require(:relationship_group).permit(
      :group_name,
      relationships_attributes: [:character_a_id, :character_b_id, :relationship_type, :directionality]
    )
  end
end