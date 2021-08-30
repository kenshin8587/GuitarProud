class RepliesController < ApplicationController
  before_action :require_user_logged_in

  def new
    @comment = Comment.find(params[:comment_id])
    @reply = current_user.replies.build
    @post = Post.find(params[:post_id])
  end

  def create
    @comment = Comment.find(params[:comment_id])
    @post = Post.find(params[:post_id])
    @reply = current_user.replies.build(reply_params)
    
    if @reply.save
      flash[:success] = '返信しました'
      redirect_to post_path(params[:post_id])
    else
      flash.now[:error] = '返信できませんでした'
      render :new
    end
  end

  def destroy

  end

  private
  
  def reply_params
    params.require(:reply).permit(:content).merge(user_id: current_user.id, comment_id: @comment.id, post_id: @post.id)
  end
end
