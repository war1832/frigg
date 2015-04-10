module Api
  class PostsController < ApplicationController
    respond_to :json
    before_action :set_post, only: [:show]

    def show
       respond_with @post
    end
    
    private
    def set_post
      @post = Post.find_by_id(params[:id])
      head 404 unless @post
    end
  end
end
