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

  validates :user_name, presence: true, length: { maximum: 16 }, uniqueness: true
  validates :name, presence: true, length: { maximum: 30 }
  validates :introduction, length: { maximum: 255 }
  validates :status_message, length: { maximum: 30 }
  
  # uploaderをマウント(carrierwave uploader)
   mount_uploader :avatar, AvatarUploader
   attr_accessor :image_x
   attr_accessor :image_y
   attr_accessor :image_w
   attr_accessor :image_h

  def follow(other_user)
    following << other_user
  end

  def follow?(other_user)
    following.include?(other_user)
  end

  def follower?(other_user)
    followers.include?(other_user)
  end
end