require 'rails_helper'

RSpec.describe "Accounts", type: :request do
  describe "GET /users/:id/accounts/edit" do
    context "ユーザーが正しい場合" do
      it "アクセスできること"
      end
    end
    context "ユーザーが正しくない場合" do
      it "root_pathにリダイレクトすること" do
      end
    end
  end
  
  describe "POST /users/:id/accounts/update" do
    context "ユーザーが正しい場合" do
      it "name, status_message, introductionを更新できること" do
      end

      it "avatarを更新できること" do
      end

    end
    context "ユーザーが正しくない場合" do
      it "更新できないこと"do 
      end

      it "root_pathにリダイレクトすること" do
      end
    end
  end
end
