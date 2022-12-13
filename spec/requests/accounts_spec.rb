require 'rails_helper'

RSpec.describe "Accounts", type: :request do
  describe "GET /users/:id/accounts/edit" do
    let(:user){ create(:user) }
    let(:other_user){ create(:other_user) }

    context "ユーザーが正しい場合" do
      it "アクセスできること" do
        log_in(user)
        get edit_user_accounts_path(user)
        expect(response).to have_http_status "200"
      end
    end

    context "ユーザーが正しくない場合" do
      it "root_pathにリダイレクトすること" do
        log_in(other_user)
        get edit_user_accounts_path(user)
        expect(response).to have_http_status "302"
        expect(response).to redirect_to root_url
      end
    end
  end

  describe "POST /users/:id/accounts/" do
    let(:user){ create(:user) }
    let(:other_user){ create(:other_user) }

    context "ユーザーが正しい場合" do
      before do
        log_in(user)
        @name = "new name"
        @message = "new message"
        @introduction = "new introduction"
        patch user_accounts_path(user.id), params: { user: { name: @name,
                                                             status_message: @message,
                                                             introduction: @introduction } }
      end

      it "name, status_message, introductionを更新できること" do
        user.reload
        expect(user.name).to eq @name
        expect(user.status_message).to eq @message
        expect(user.introduction).to eq @introduction
      end

      it "avatarを更新できること" do
      end

      it "更新に成功した場合、users/:id にリダイレクトすること" do
        expect(response).to redirect_to user_path(user)
      end

      it "更新に失敗した場合、/users/:id/accounts/をレンダリングすること" do
        new_name = "a" * 31
        patch user_accounts_path(user.id), params: { user: { name: new_name } }
        expect(user.name).not_to eq new_name
        expect(response).to render_template('edit')
      end
    end

    context "ユーザーが正しくない場合" do
      before do
        log_in(other_user)
        @name = "new name"
        @message = "new message"
        @introduction = "new introduction"
        patch user_accounts_path(user.id), params: { user: { name: @name,
                                                             status_message: @message,
                                                             introduction: @introduction } }
      end

      it "更新できないこと"do 
        user.reload
        expect(user.name).not_to eq @name
        expect(user.status_message).not_to eq @message
        expect(user.introduction).not_to eq @introduction
      end

      it "root_pathにリダイレクトすること" do
        expect(response).to redirect_to root_url
      end
    end
  end
end
