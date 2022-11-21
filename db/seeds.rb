User.create!( email: "hogehoge@example.com",
              password: "password")

User.create!( email: "foobar@example.com",
              password: "password")

10.times do |n|
  User.create!( email: "test#{n}@example.com",
                password: "password"
              )
end

# リレーションシップの作成
user  = User.find_by(email: "hogehoge@example.com")
user2 = User.find_by(email: "foobar@example.com")
user.followers << user2
user.following << user2

room = Room.create()

# Roomの作成
user.user_rooms.new(room_id: room.id)
user2.user_rooms.new(room_id: room.id)