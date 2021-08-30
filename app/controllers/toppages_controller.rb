class ToppagesController < ApplicationController
  def index
    if logged_in?
      @posts = Post.order(id: :desc).page(params[:page])

      if params[:bandname].present?
        @posts = @posts.get_by_bandname(params[:bandname])
      end
      
      if params[:part].present?
        @posts = @posts.get_by_part(params[:part])
      end
    end
  end
end
