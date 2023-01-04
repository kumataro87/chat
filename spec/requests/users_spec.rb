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

    context "ログインしている場合" do
      let(:user){ create(:user) }
      let(:other_user){ create(:other_user) }

      before do
        log_in(user)
      end

      context "自身のプロフィールにアクセスした場合" do
        it "トーク(Link)が表示されていないこと" do
          get user_path(user)
          expect(response.body).not_to include "トークへ"
        end

        it "プロフィールを変更(リンク)が表示されていること" do
          get user_path(user)
          expect(response.body).to include "プロフィールを編集"
        end

        it "友達追加が表示されていないこと" do
          get user_path(user)
          expect(response.body).not_to include "友達追加"
        end

      end
      
      context "Friendのプロフィールにアクセスした場合" do
        before do
          user.followers << other_user
          user.following << other_user
        end

        it "トーク(Link)が表示されていること" do
          get user_path(other_user)
          expect(response.body).to include "トークへ"
        end
        
        it "プロフィールを変更(リンク)が表示されていないこと" do
          get user_path(other_user)
          expect(response.body).not_to include "プロフィールを変更"
        end
        
        it "友達追加が表示されていないこと" do
          get user_path(other_user)
          expect(response.body).not_to include "友達追加"
        end
      end

      context "フォローしていないユーザーのプロフィールにアクセスした場合" do
        it "トーク(Link)が表示されていない" do
          get user_path(other_user)
          expect(response.body).not_to include "トークへ"
          expect{user.followers << other_user}.to change{ Relationship.count }.by(1)
          get user_path(other_user)
          expect(response.body).not_to include "トークへ"
        end
        
        it "プロフィールを変更(リンク)が表示されていないこと" do
          get user_path(other_user)
          expect(response.body).not_to include "プロフィールを変更"
          expect{user.followers << other_user}.to change{ Relationship.count }.by(1)
          get user_path(other_user)
          expect(response.body).not_to include "プロフィールを変更"
        end
        
        it "友達追加が表示されていること" do
          get user_path(other_user)
          expect(response.body).to include "友達追加"
          expect{user.followers << other_user}.to change{ Relationship.count }.by(1)
          get user_path(other_user)
          expect(response.body).to include "友達追加"
        end
      end
    end
  end
end
