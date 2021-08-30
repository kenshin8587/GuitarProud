class CommentsController < ApplicationController
  before_action :require_user_logged_in
  
  def new
    @comment = current_user.comments.build
    @post = Post.find(params[:post_id])
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.build(comment_params)
    
    if @comment.save
      flash[:success] = 'コメントしました'
      redirect_to post_path(params[:post_id])
    else
      flash.now[:error] = 'コメントできませんでした'
      render :new
    end
  end

  def destroy
    @comment = current_user.comments.find_by(post_id: params[:post_id])
    
    if @comment.destroy
      flash[:success] = 'コメントが削除されました'
      redirect_back(fallback_location: post_path(params[:post_id]))
    else
      flash.now[:error] = 'コメントが削除されませんでした'
      render 'toppages/index'
    end
  end

  private
  
  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id, post_id: @post.id)
  end
end
