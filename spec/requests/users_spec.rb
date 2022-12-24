require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /users/index(root_path)" do
    let!(:user)    { create(:user) }
    let!(:friend)  { create(:other_user, name: "friend") }
    let!(:followed){ create(:other_user, name: "followed") }
    let!(:follower){ create(:other_user, name: "follower") }

    before do
      user.following << friend
      user.followers << friend
      user.following << followed
    end
    
    context "ログインしている場合" do
      before do
        log_in(user)
        get root_path
      end

      it "相互フォローしているユーザーが表示されること" do
        expect(response.body).to include 'friend'
      end

      it "フォローしているユーザーが表示されること" do
        expect(response.body).to include "followed"
      end
      
      it "フォロワーが表示されること" do
        expect(response.body).to include "follower"
      end
    end
    
    context "ログインしていない場合" do
      it "200を返すこと" do
        get root_path
        expect(response).to have_http_status "200"
      end
    end
  end

  describe "GET /users/show" do
    context "ログインしていない場合" do
      let(:user){ create(:user) }
      
      it "ログインページにリダイレクトすること" do
        get user_path(user)
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "自身のプロフィールにアクセスした場合" do
      it "トーク(Link)が表示されていないこと" do
      end
      it "プロフィールを変更(リンク)が表示されていること" do
      end
    end

    context "Friendのプロフィールにアクセスした場合" do
      it "トーク(Link)が表示されていること" do
      end

      it "プロフィールを変更(リンク)が表示されていないこと" do
      end
    end
  end
end
