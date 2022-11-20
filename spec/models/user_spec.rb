require 'rails_helper'

RSpec.describe User, type: :model do
  describe Relationship do
    let!(:user){ create(:user) }
    let!(:other_user){ create(:other_user) }

    it "active_relationshipsが有効であること" do
      r = user.active_relationships.build(followed_id: other_user.id)
      expect(r).to be_valid
    end
    
    it "foreign_keyがnilの場合無効であること" do
      r = user.active_relationships.build()
      expect(r).to_not be_valid
    end
    
    it "passive_relationshipsが有効であること" do
      r = other_user.passive_relationships.build(follower_id: user.id)
      expect(r).to be_valid
    end
    
    it "foreign_keyがnilの場合無効であること" do
      r = user.passive_relationships.build()
      expect(r).to_not be_valid
    end
    
    it "followingが有効であること" do
      other_user2 = create(:other_user)
      user.following << [other_user, other_user2]
      expect(user.following.count).to eq 2
    end
    
        
    it "followersが有効であること" do
      other_user2 = create(:other_user)
      [other_user, other_user2].each do |u|
        u.followers << user
      end
      expect(user.following.count).to eq 2
    end
  end
end
