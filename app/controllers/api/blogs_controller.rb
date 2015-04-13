module Api
  class BlogsController < ApplicationController
    respond_to :json
    before_action :set_blog, only: [:show]
    
    def show
      respond_with @blog
    end
    
    private
    def set_blog
      @blog = Blog.find(params[:id])
      head 404 unless @blog
    end
  end
end
