class User < ApplicationRecord
  has_many :messages
  has_many :sent_chats, class_name: 'Chat', foreign_key: 'sender_id'
  has_many :received_chats, class_name: 'Chat', foreign_key: 'receiver_id'
  has_many :received_messages, through: :received_chats, source: :messages
  
  validates :email, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
end

"""
User
email (string)
first_name (string)
last_name (string)

Chat
sender_id (integer)
receiver_id (integer)

Message
chat_id (integer)
user_id (integer)
body (text)
"""

