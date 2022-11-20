require 'rails_helper'

RSpec.describe Relationship, type: :model do
  context "followed_idに紐づくアカウントが削除された場合" do
    let(:user){ create(:user, :user_with_following) }
    
    it "関連レコードも削除されること" do
       other_user = user.following.last
       expect{ other_user.destroy }.to change{ user.following.count}.by(-1)
    end
  end
  
  context "follower_idに紐づくアカウントが削除された場合" do
    let(:user){ create(:user, :user_with_followers) }
    
    it "関連レコードも削除されること" do
       other_user = user.followers.last
       expect{ other_user.destroy }.to change{ user.followers.count}.by(-1)
    end
  end
end
