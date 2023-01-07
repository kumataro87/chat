require 'rails_helper'

RSpec.describe "Searches", type: :request do
  describe "GET /index" do
    context "ログインしていない場合" do
      it "ログインページにリダイレクトすること" do
      end
    end

    context "ログインしている場合" do
      let!(:user){ create(:user) }

      context "パラメータ無でアクセスした場合" do
        it "flashが表示されないこと" do
          get search_index_path
          expect(flash).not_to be_present
        end
      end
      
      context "ユーザーが存在する場合" do
        it "ユーザーページに遷移すること" do
          get search_index_path, params: { user_name: 'tarou' }
          expect(response).to redirect_to user_path(user)
          expect(flash).not_to be_present
        end
      end
      
      context "ユーザーが存在しない場合" do
        it "検索ページがrenderされること" do
          get search_index_path, params: { user_name: 'non_existent_username' }
          expect(response).to render_template(:index)
        end
        
        it "flashが表示されること" do
          get search_index_path, params: { user_name: 'non_existent_username' }
          expect(flash[:alert]).to be_present
        end
        
        it "リダイレクトした場合、flashが消えること" do
          get search_index_path, params: { user_name: 'non_existent_username' }
          expect(flash[:alert]).to be_present
          get search_index_path, params: { user_name: 'tarou' }
          expect(response).to redirect_to user_path(user)
          expect(flash[:alert]).not_to be_present
        end
      end

    end
  end
end
