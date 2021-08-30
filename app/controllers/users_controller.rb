class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show, :edit, :update, :destroy]
  def index
    @users = User.order(id: :desc).page(params[:page]).per(25)
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order(id: :desc).page(params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = 'アカウントが作成されました'
      redirect_to login_path
    else
      flash.now[:error] = 'アカウント作成に失敗しました'
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    
    if @user.update(user_params)
      flash[:success] = 'プロフィールを編集しました'
      redirect_to @user
    else
      flash.now[:error] = '編集できませんでした'
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    
    flash[:success] = 'アカウントが削除されました'
    redirect_to root_url
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
