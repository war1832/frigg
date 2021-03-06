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
    respond_to do |format|
      if user
        @editor.user = user
          if @editor.save
            format.html { redirect_to blog_editors_path }
            format.json { render :show, status: :created, location: @editor }
          else
            format.html { render :new }
            format.json { render json: @editor.errors, status: :unprocessable_entity }
          end
      else
         format.html { redirect_to new_blog_editor_path , alert: 'Invalid Email.' }
      end
   end
  end

  def destroy
    @editor.destroy
    respond_to do |format|
      format.html { redirect_to blog_editors_path }
      format.json { head :no_content }
    end
  end

  private
    def set_blog
      @blog = Blog.find(params[:blog_id])
      raise ActiveRecord::RecordNotFound unless @blog
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
