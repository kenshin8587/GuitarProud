class MessagesController < ApplicationController
  before_action :require_user_logged_in

  def create
    if Entry.where(user_id: current_user.id, room_id: params[:message][:room_id]).present?
      @message = Message.create(message_params)
      
      #respond_to do |format|
        #format.html
        #format.json
      #end
    else
      flash[:danger] = "メッセージ送信に失敗しました。"
    end
    redirect_to room_path(@message.room_id)
  end

  private

  def message_params
    params.require(:message).permit(:user_id, :content, :room_id).merge(user_id: current_user.id)
  end
end
