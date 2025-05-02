class Message < ApplicationRecord
  belongs_to :chat
  belongs_to :user
  
  validates :chat_id, presence: true
  validates :user_id, presence: true
  validates :body, presence: true
  
  validate :user_must_be_in_chat
  
  private
  
  def user_must_be_in_chat
    if chat && user && chat.sender_id != user.id && chat.receiver_id != user.id
      errors.add(:user_id, "must be either the sender or receiver of the chat")
    end
  end
end