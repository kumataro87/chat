class UsersController < ApplicationController
  include SessionHelper
  before_action :authenticate_user!, only: :show
  
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    redirect_to root_path if current_user?(@user)
    # ルームが存在するか確認する
    unless @user.rooms.empty?
      @user.rooms.each do |room|
        if current_user.rooms.include?(room)
          @is_room = true
          @room = room
          break
        end
      end
    end
    # ルームが存在しない場合は作成する
    unless @is_room
      @room = Room.new
      @user_room = UserRoom.new
    end
  end
end
