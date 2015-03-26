class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :set_blog, only: [:new, :index, :show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:show]
  
  rescue_from ActiveRecord::RecordNotFound do |exception|
    render 'post_not_found'
  end

  # GET /posts
  # GET /posts.json
  def index
    @posts = @blog.posts.order(created_at: :DESC).paginate(page: params[:page], per_page: 5)
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    get_rank if current_user
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    @post.user = current_user
    @post.blog = current_user.blogs.find_by_name(params[:blog_id])
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

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
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

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to :action => "index" }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end
    
    def set_blog
      @blog = Blog.find(params[:blog_id])
      render '/blogs/blog_not_found' unless @blog
    end
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :body)
    end
    
    def get_rank
      @rating = Rating.where(post_id: @post.id, user_id: current_user.id).first 
      unless @rating 
        @rating = Rating.create(post_id: @post.id, user_id: current_user.id, score: 0)
      end
    end
end
