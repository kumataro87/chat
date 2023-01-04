require 'rails_helper'
RSpec.describe Room, type: :system do
  context "相互フォローの場合" do
    let(:user){ create(:user) }
    let(:other_user){ create(:other_user) }

    before do
      user.follow(other_user)
      other_user.follow(user)
    end
    
    it "ルームが作成できること" do
      log_in(user)
      visit user_path(other_user)
      # 初めてトークを開くとき、ルームが作成されること
      expect{ click_button "トークへ" }.to change(Room, :count).by(1)
      click_on "ホームに戻る"
      expect(current_path).to eq root_path
      visit user_path(other_user)
      # 2回目以降はルームが作成されないこと
      expect{ click_on "トークへ" }.to_not change(Room, :count)
    end
  end
end