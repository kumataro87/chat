require 'rails_helper'

RSpec.describe User, type: :model do
  describe Relationship do
    let!(:user){ create(:user)}
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
  end
end
