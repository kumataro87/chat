User.create!( user_name: "anya"
              name: "Anya",
              email: "hogehoge@example.com",
              password: "password")

User.create!( user_name: "desmond"
              name: "Desmond",
              email: "foobar@example.com",
              password: "password")

10.times do |n|
  User.create!( 
                name:  Faker::Name.name,
                email: "test#{n}@example.com",
                password: "password"
              )
end

# リレーションシップの作成
user  = User.find_by(email: "hogehoge@example.com")
user2 = User.find_by(email: "foobar@example.com")
user.followers << user2
user.following << user2

i = 0
User.where.not(id: 1..2).each do |u|
  if i < 2
    user.followers << u && user.following << u
  elsif i < 4
    user.followers << u
  elsif i < 6
    user.following << u
  else
    next
  end
  i += 1
end

# Roomの作成
room = Room.create()
user.user_rooms.new(room_id: room.id)
user2.user_rooms.new(room_id: room.id)