class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :messages,   dependent: :destroy
  has_many :user_rooms, dependent: :destroy
  has_many :rooms, through: :user_rooms
  has_many :active_relationships,  class_name: "Relationship",
                                   foreign_key: "follower_id",
                                   dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship",
                                   foreign_key: "followed_id",
                                   dependent: :destroy
  # follwed_idの集合を作成
  has_many :following, through: :active_relationships, source: :followed
  # following_idの集合を作成
  has_many :followers, through: :passive_relationships
  # uploaderをマウント(carrierwave uploader)
   mount_uploader :avatar, AvatarUploader

  def follow(other_user)
    following << other_user
  end
end