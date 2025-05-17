class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def google_oauth2
      # 認証情報を元にユーザーを取得または作成
      @user = User.from_omniauth(request.env['omniauth.auth'])
  
      if @user.persisted?
        # 正常にログインできるユーザーならログイン＋リダイレクト
        sign_in_and_redirect @user, event: :authentication
        set_flash_message(:notice, :success, kind: 'Google') if is_navigational_format?
      else
        # 何かエラーがあって保存できなかった場合
        session['devise.google_data'] = request.env['omniauth.auth'].except(:extra) # セキュリティのためextraは除く
        redirect_to new_user_registration_url, alert: 'Googleログインに失敗しました。'
      end
    end
  end