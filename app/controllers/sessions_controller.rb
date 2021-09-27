class SessionsController < ApplicationController
  before_action :require_user_logged_in, only: [:destroy]

  def new
  end

  def create
    email = params[:session][:email].downcase
    password = params[:session][:password]
    
    if login(email, password)
      flash[:success] = 'ようこそ！'
      redirect_to @user
    else
      flash.now[:danger] = 'ログインできませんでした'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:succuss] = 'ログアウトしました'
    redirect_to root_url
  end

  private
  
  def login(email, password)
    @user = User.find_by(email: email)
    
    if @user && @user.authenticate(password)
      session[:user_id] = @user.id
      true
    else
      false
    end
  end
end
