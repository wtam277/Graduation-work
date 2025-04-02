class CharactersController < ApplicationController
    before_action :set_comic
    before_action :set_character, only: [:edit, :update]
  
    def index
      @character = @comic.characters.build  # 新規作成フォーム用
      @characters = @comic.characters.order(:id).reject(&:new_record?)
      @relationship_groups = @comic.relationship_groups.includes(:relationships)
    end

    def new
      @character = @comic.characters.build  # 新規作成用インスタンス
      @characters = @comic.characters  # 関連するキャラクターを取得
    end
  
    def create
      @character = @comic.characters.build(character_params)
      if @character.save
        redirect_to comic_characters_path(@comic), notice: "キャラクターを作成しました！"
      else
        @characters = @comic.characters
        render :index
      end
    end
  
    def edit

    end
  
    def update
      if @character.update(character_params)
        redirect_to comic_characters_path(@comic), notice: "キャラクターを更新しました！"
      else
        render :edit
      end
    end

    def destroy
      @character = @comic.characters.find(params[:id])
      @character.destroy
      redirect_to comic_characters_path(@comic), notice: "相関図が削除されました！"
    end
  
    private
  
    def set_comic
      @comic = Comic.find(params[:comic_id])
    end
  
    def set_character
      @character = @comic.characters.find(params[:id])
    end
  
    def character_params
      params.require(:character).permit(:name, :description, :icon)
    end
  end