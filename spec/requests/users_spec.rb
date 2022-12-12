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
      
    it "フォローしているユーザーが表示されること" do
      log_in(user)
      get root_path
      expect(response.body).to include 'friend'
      expect(response.body).to include "followed"
      expect(response.body).not_to include "follower"
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
      it "プロフィールを変更(リンク)が表示されていること"
      end
    end

    context "Friendのプロフィールにアクセスした場合" do
      it "トーク(Link)が表示されていること" do
      end

      it "プロフィールを変更(リンク)が表示されていないこと"
      end
    end
  end
end
