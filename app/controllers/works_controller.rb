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
      flash[:notice] = "作成されました！"
      redirect_to works_path
    else
      render :new
    end
  end

  def edit
    @comic = Comic.find(params[:id])
  end
  
  def update
    @comic = Comic.find(params[:id])
    if @comic.update(comic_params)
      redirect_to works_path, notice: "更新しました"
    else
      render :index
    end
  end

  def destroy
      @comic = Comic.find(params[:id])
      @comic.destroy
      redirect_to comics_path, notice: "削除しました"
  end


  private

  def comic_params
    params.require(:comic).permit(:title, :total_page)
  end
end
