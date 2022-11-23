class RoomsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @room = Room.create
    UserRoom.create(room_id: @room.id, user_id: current_user.id)
    UserRoom.create(user_room_params)
    redirect_to @room
  end
  
  def show
    @room = Room.find(params[:id])
    if @room && @room.users.include?(current_user)
      @messages = @room.messages
      @message = Message.new
      @user_rooms = @room.user_rooms
    else
      redirect_back(fallback_location: root_path)
    end
  end
  
  private
  
    def user_room_params
      params.require(:user_room).permit(:user_id).merge(room_id: @room.id)
    end
end
