class UsersController < ApplicationController
  include SessionHelper
  before_action :authenticate_user!, only: :show
  
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    unless @user.id == current_user.id
      unless @user.rooms.empty?
        @user.rooms.each do |room|
          if current_user.rooms.include?(room)
            @is_room = true
            @room = room
            break
          end
        end
      end
    end
    if @is_room
    else
      @room = Room.new
      @user_room = UserRoom.new
    end
  end
end
