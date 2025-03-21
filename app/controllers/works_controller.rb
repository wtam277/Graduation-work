class WorksController < ApplicationController
  # ログインを必須の状態にする
  before_action :authenticate_user!, only: [:new, :create]  
  def index
    @comics = current_user.comics
  end

  def show
    @comic = Comic.find(params[:id])  # 特定の作品を取得
  end

  def new
    @comic = Comic.new  # 新規作成フォーム用
  end

  def create
    @comic = current_user.comics.build(comic_params)
    if @comic.save
      redirect_to works_path, notice: '作品を追加しました！'
    else
      render :new
    end
  end

  private

  def comic_params
    params.require(:comic).permit(:title, :total_page)
  end
end
