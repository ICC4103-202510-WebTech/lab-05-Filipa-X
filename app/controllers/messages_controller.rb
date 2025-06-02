class MessagesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @messages = @messages.includes(:user, :chat).order(created_at: :desc)
  end

  def show
    # @message 
  end

  def new
    @chats = Chat.all
    @users = User.all
  end

  def create
    if params[:chat_id]
      @chat = Chat.find(params[:chat_id])
      @message.chat = @chat
    end

    if @message.save
      redirect_to chat_path(@message.chat), notice: 'Message was successfully sent.'
    else
      if params[:chat_id]
        render 'chats/show', status: :unprocessable_entity
      else
        @chats = Chat.all
        @users = User.all
        render :new, status: :unprocessable_entity
      end
    end
  end

  def edit
    @chats = Chat.all
    @users = User.all
  end

  def update
    if @message.update(message_params)
      redirect_to @message, notice: 'Message was successfully updated.'
    else
      @chats = Chat.all
      @users = User.all
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def message_params
    params.require(:message).permit(:body, :user_id, :chat_id)
  end
end
