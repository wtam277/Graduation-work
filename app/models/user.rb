class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         has_many :comics, dependent: :destroy  # ユーザーが削除されたら関連する作品も削除
  has_one_attached :avatar
  
  before_validation :set_default_username, on: :create

  private

  def set_default_username
    self.username = "ユーザー" if username.blank?
  end
end
