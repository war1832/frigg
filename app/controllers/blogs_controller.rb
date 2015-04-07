class BlogsController < ApplicationController
  before_action :set_blog, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:show, :search]
  before_action :check_permission, except: [:show, :index]
  rescue_from ActiveRecord::RecordNotFound do |exception|
    render 'blog_not_found'
  end

  def index
    @blogs = Blog.where(user: current_user)
  end

  def show
    @posts = @blog.posts.order(created_at: :DESC).paginate(page: params[:page], per_page: 5)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
    @blog = Blog.new
  end

  def edit
  end

  def create
    @blog = current_user.blogs.create blog_params
    respond_to do |format|
      if @blog.save
        format.html { redirect_to new_blog_post_path(@blog) }
        format.json { render :show, status: :created, location: @blog }
      else
        format.html { render :new }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @blog.update(blog_params)
        format.html { redirect_to @blog }
        format.json { render :show, status: :ok, location: @blog }
      else
        format.html { render :edit }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @blog.destroy
    respond_to do |format|
      format.html { redirect_to blogs_url }
      format.json { head :no_content }
    end
  end
  
  def search
    @blogs = Blog.search(params[:search]).order("created_at DESC") if params[:search]
  end

  private

    def set_blog
      @blog = Blog.find(params[:id])
      render 'blog_not_found' unless @blog
    end

    def blog_params
      params.require(:blog).permit(:name, :title, :second_title)
    end

    def check_permission
      unless current_user.admin? || @blog.user == current_user
        head :unauthorized
      end
    end
end
