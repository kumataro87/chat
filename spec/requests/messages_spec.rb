require 'rails_helper'

RSpec.describe "Messages", type: :request do
  describe "POST /messages" do
    let(:room){ create(:room) }
    let(:user){ create(:user) }
    let(:room_user){ create(:other_user) }
    let(:unpaired_user){ create(:other_user) }
    
    before do
      create(:user_room, room_id: room.id, user_id: user.id)
      create(:user_room, room_id: room.id, user_id: room_user.id) 
    end
    
    context "正しいユーザーの場合" do
      it "登録できること" do
      post user_session_path , params: { user: { email: "hogehoge@example.com",
                                                 password: "password" } }
      expect{ post messages_path, params: {message: { content: "hoge", room_id:1 } } 
        
      }.to change(Message, :count).by(1)
      end
    end
    
    context "正しいユーザーでない場合" do
      it "登録できないこと" do
      post user_session_path , params: { user: { email: unpaired_user.email,
                                                 password: "password" } }
      expect{ post messages_path, params: {message: { content: "hoge", room_id:1 } } 
        
      }.to_not change(Message, :count)
      end
    end
  end
end
