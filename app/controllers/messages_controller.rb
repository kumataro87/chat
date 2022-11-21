class MessagesController < ApplicationController
  # before_action :correct_user, only: [:create]
  
  def create
    # message = Message.find(params[:id])
    message = current_user.messages.new(message_params)
    if message.save
    else  
      flash[:alert] = "メッセージの送信に失敗しました"
    end
    redirect_to room_path(message.room.id)
  end
  
  private
  
    def message_params
      params.require(:message).permit(:content, :room_id)
    end
    
    # def correct_user
    #   room = Message.find_by(params[:message)
    #   redirect_to root_url unless current_user
    # end
end
