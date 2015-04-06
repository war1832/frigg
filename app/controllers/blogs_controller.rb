class BlogsController < ApplicationController
  before_action :set_blog, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:show, :search]
  rescue_from ActiveRecord::RecordNotFound do |exception|
    render 'blog_not_found'
  end
  # GET /blogs
  # GET /blogs.json
  def index
    @blogs = Blog.where(user: current_user)
  end

  # GET /blogs/1
  # GET /blogs/1.json
  def show
    @posts = @blog.posts.order(created_at: :DESC).paginate(page: params[:page], per_page: 5)
    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /blogs/new
  def new
    @blog = Blog.new
  end

  # GET /blogs/1/edit
  def edit
  end

  # POST /blogs
  # POST /blogs.json
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

  # PATCH/PUT /blogs/1
  # PATCH/PUT /blogs/1.json
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

  # DELETE /blogs/1
  # DELETE /blogs/1.json
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
    # Use callbacks to share common setup or constraints between actions.
    def set_blog
      @blog = Blog.find(params[:id])
      render 'blog_not_found' unless @blog
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def blog_params
      params.require(:blog).permit(:name, :title, :second_title)
    end
end
