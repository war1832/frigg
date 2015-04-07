class EditorsController < ApplicationController
  before_action :set_blog, only: [:new, :index, :create, :destroy]
  before_action :set_editor, only: [:destroy]
  before_action :authenticate_user!, except: [:show]
  before_action :check_permission, except: [:show]

  def index
    @editors = Editor.where(blog: @blog)
  end

  def new
    @editor = Editor.new
  end

  def create
    @editor = @blog.editors.build
    user = User.find_by_email params[:user_email]
    @editor.user = user
    respond_to do |format|
      if @editor.save
        format.html { redirect_to @editor, notice: 'Editor was successfully created.' }
        format.json { render :show, status: :created, location: @editor }
      else
        format.html { render :new }
        format.json { render json: @editor.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @editor.destroy
    respond_to do |format|
      format.html { redirect_to editors_url, notice: 'Editor was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_blog
      @blog = Blog.find(params[:blog_id])
      render '/blogs/blog_not_found' unless @blog
    end

    def set_editor
      @editor = Editor.find(params[:id])
    end
    
    def check_permission
      unless current_user.admin? || @blog.user == current_user
        head :unauthorized
      end
    end

    def editor_params
      params[:editor]
    end
end
