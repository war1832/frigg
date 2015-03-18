class HomeController < ApplicationController
  def index
    @posts = Post.order(created_at: :DESC).paginate(page: params[:page], per_page: 5)
  end
end
