class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  #ログイン後に、works(作品一覧)へリダイレクトする(devise)
  def after_sign_in_path_for(resource)
    works_path  # /works にリダイレクト
  end

end
