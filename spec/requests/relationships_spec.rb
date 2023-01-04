require 'rails_helper'

RSpec.describe "Relationships", type: :request do
  describe "POST /create" do
    let!(:user){ create(:user) }
    let!(:other_user){ create(:other_user) }

    context "ログインしている場合" do
      context "フォローした場合" do
        before do
          log_in(user)
          post relationships_path(other_user.id), params: { followed_id: other_user.id }
        end

        it "Relationship.countが1件になること" do
          expect(Relationship.count).to eq 1
        end
      end
    end
    context "ログインしていない場合" do
      it "ログインページにリダイレクトすること" do
        # post relationships_path(other_user.id), params: { user: { followed_id: other_user.id } }
      end
    end
  end
end
