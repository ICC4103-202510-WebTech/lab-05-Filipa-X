# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
Message.destroy_all
Chat.destroy_all
User.destroy_all

users = []
10.times do |i|
  users << User.create!(
    email: "user#{i + 1}@mail.com",
    first_name: "FirstName#{i + 1}",
    last_name: "LastName#{i + 1}"
  )
end

chats = []
10.times do
  sender, receiver = users.sample(2)
  chats << Chat.create!(
    sender_id: sender.id,
    receiver_id: receiver.id
  )
end

10.times do |i|
  chat = chats.sample
  user_id = [chat.sender_id, chat.receiver_id].sample

  Message.create!(
    chat_id: chat.id,
    user_id: user_id,
    body: "This is message number #{i + 1}"
  )
end
