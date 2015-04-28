class CommentsController < ApplicationController
  before_action :set_comment, only: [:destroy]
  before_action :set_blog
  before_action :set_post
  before_action :authenticate_user!, only: [:destroy]
  before_action :check_permission, only: [:destroy]
  before_action :verify_captcha, only: [:create]

  def create
    comment = @post.comments.build comment_params
    comment.user = current_user
    respond_to do |format|
      if comment.valid?
        if comment.save
         format.html { redirect_to blog_post_path(@blog, @post) }
        else
          format.html { redirect_to( blog_post_path(@blog, @post),
                      :flash => { :error => 'Error to save comment. Please try again.' } ) }
        end
      else
          format.html { redirect_to( contact_new_path, :flash => { :error => 'Invalid comment.' } ) }
      end
    end
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to blog_post_path(@blog, @post) }
      format.json { head :no_content }
    end
  end

  private
  def set_comment
    @comment = Comment.find(params[:id])
  end
  def comment_params
    params[:comment].permit(:body)
  end
  def set_blog
    @blog = Blog.find(params[:blog_id])
    raise ActiveRecord::RecordNotFound unless @blog
  end
  def set_post
    @post = Post.find(params[:post_id])
  end
  def check_permission
    unless current_user && current_user.can_remove_comment?(@comment)
      head :unauthorized
    end
  end
  def verify_captcha
    unless verify_recaptcha
      respond_to do |format|
        format.html { redirect_to( blog_post_path(@blog, @post), :flash => { :error => 'Are you bot?.' } ) }
      end
    end
  end
end
