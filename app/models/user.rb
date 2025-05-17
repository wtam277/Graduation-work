class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

         has_many :comics, dependent: :destroy  # ユーザーが削除されたら関連する作品も削除
  has_one_attached :avatar
  
  before_validation :set_default_username, on: :create

  def self.from_omniauth(auth)
    user = User.find_by(email: auth.info.email)

    unless user
      user = User.create(
        email: auth.info.email,
        password: Devise.friendly_token[0, 20]
      )
    end

    user
  end

  private

  def set_default_username
    self.username = "ユーザー" if username.blank?
  end
end
