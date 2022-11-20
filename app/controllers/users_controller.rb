class UsersController < ApplicationController
  before_action :authenticate_user!, only: :show
  
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    unless @user.id == current_user.id
    current_user_room = @current_user.user_rooms.all
      @user.user_rooms.each do |room|
        if current_user_room.include(room) then
          is_room = true
          room_id = room.id
          break
        end
      end
    end
    if is_room
    else
      @room = Room.new
      @user_rooms = UserRooms.new
    end
  end
end
