require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /users/show" do
    context "ログインしていない場合" do
      let(:user){ create(:user) }
      
      it "ログインページにリダイレクトすること" do
        get user_path(user)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
