class PostsController < ApplicationController
  before_action :set_blog, only: [:new, :index, :show, :edit, :update, :create, :destroy]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:show]
  before_action :check_permission, except: [:show]
  
  rescue_from ActiveRecord::RecordNotFound do |exception|
    render 'post_not_found'
  end

  def index
    @posts = @blog.posts.order(created_at: :DESC).paginate(page: params[:page], per_page: 5)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    get_rank if current_user
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
    @post = @blog.posts.build post_params
    @post.user = current_user
    respond_to do |format|
      if @post.save
        format.html { redirect_to :action => "show", :id => @post.id }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to :action => "show", :id => @post.id }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to @blog }
      format.json { head :no_content }
    end
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end
    
    def set_blog
      @blog = Blog.find(params[:blog_id])
      render '/blogs/blog_not_found' unless @blog
    end
    
    def post_params
      params.require(:post).permit(:title, :body)
    end
    
    def get_rank
      @rating = Rating.find_or_create_by(post: @post, user: current_user) 
    end
    
    def check_permission
      unless current_user.can_manager? @blog
        head :unauthorized
      end
    end
end
