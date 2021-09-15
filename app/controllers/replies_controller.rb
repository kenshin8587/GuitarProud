class RepliesController < ApplicationController
  before_action :require_user_logged_in

  def show
    @comment = Comment.find(params[:comment_id])
    #@comment = Comment.find(:comment_id)
    @reply = Reply.where(comment_id: @comment.id)
    @reply_new = current_user.replies.build
    @comment = Comment.find(params[:comment_id])
    @post = Post.find(params[:post_id])
  end

  #def new
    #@reply_new = current_user.replies.build
    #@comment = Comment.find(params[:comment_id])
    #@post = Post.find(params[:post_id])
  #end

  def create
    @comment = Comment.find(params[:comment_id])
    @post = Post.find(params[:post_id])
    @reply_new = current_user.replies.build(reply_params)
    #@reply = Reply.where(comment_id: @comment.id)
    
    if @reply_new.save
      flash[:success] = '返信しました'
      redirect_to request.referer
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
