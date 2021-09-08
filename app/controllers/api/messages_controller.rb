class Api::MessagesController < ApplicationController
  
  def index

    @room = Room.find(params[:room_id])
    
    @messages = @room.messages.includes(:user).where('id > ?', params[:id])
    
    respond_to do |format|
      format.html
      format.json
    end
    
  end

end
