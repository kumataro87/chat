FactoryBot.define do
  factory :user do
    email { "hogehoge@gmail.com" }
    password { "password" }
    
    trait :user_with_following do
      after(:create) do |user|
        3.times do
          user.following << create(:other_user)
        end
      end
    end
    
    trait :user_with_followers do
      after(:create) do |user|
        3.times do
          user.followers << create(:other_user)
        end
      end
    end
  end
  
  factory :other_user, class: User do
    sequence(:email){ |n| "test#{n}@example.com" }
    password {"password"}
  end
end