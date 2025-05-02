class MessagesController < ApplicationController
  def new
    @message = Message.new
    @chats = Chat.all
    @users = User.all
  end
  
  def index
    @messages = Message.includes(:user, :chat).order(created_at: :desc)
  end

  def show
    @message = Message.find(params[:id])
  end
  
  def create
    if params[:chat_id]
      @chat = Chat.find(params[:chat_id])
      @message = @chat.messages.new(message_params)
      
      if @message.save
        redirect_to chat_path(@chat), notice: 'Message was successfully sent.'
      else
        render 'chats/show', status: :unprocessable_entity
      end
    else
      @message = Message.new(message_params)
      
      if @message.save
        redirect_to chat_path(@message.chat), notice: 'Message was successfully sent.'
      else
        @chats = Chat.all
        @users = User.all
        render :new, status: :unprocessable_entity
      end
    end
  end
  
  private
  
  def message_params
    params.require(:message).permit(:body, :user_id, :chat_id)
  end
end