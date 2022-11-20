FactoryBot.define do
  factory :user do
    email { "hogehoge@gmail.com" }
    password { "password" }
  end
  
  factory :other_user, class: User do
    sequence(:email){ |n| "test#{n}@example.com" }
    password {"password"}
  end
end