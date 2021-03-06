class PostsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user_for_post, only: [:destroy]
  
  def show
    @post = Post.find(params[:id])
    @user = User.where(post_id: @post.id)
    @comment_new = current_user.comments.build
    @comments = Comment.where(post_id: @post.id)
    #@replies = Reply.all
  end
  
  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    
    if @post.save
      flash[:success] = '投稿しました'
      redirect_to root_url
    else
      flash.now[:danger] = '投稿できませんでした'
      render :new
    end
    
  end

  def edit
    @post = Post.find_by(id: params[:id])
  end

  def update
    @post = Post.find_by(id: params[:id])
    
    if @post.update(post_params)
      flash[:success] = '編集しました'
      redirect_to root_url
    else
      flash.now[:danger] = '編集できませんせした'
      render :edit
    end
    
  end

  def destroy
    @post.destroy
    
    flash[:success] = '投稿を削除しました'
    redirect_to root_url
  end
  
  private
  
  def post_params
    params.require(:post).permit(:bandname, :member, :part, :remark, images_attributes: [:image_content])
  end
  
  def correct_user_for_post
    @post = current_user.posts.find_by(id: params[:id])
    
    unless @post
      redirect_to root_url
    end
  end
end
