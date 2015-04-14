class CommentsController < ApplicationController
  before_action :set_comment, only: [:destroy]
  before_action :set_blog
  before_action :set_post
  before_action :authenticate_user!, only: [:destroy]
  before_action :check_permission, only: [:destroy]
  
  
  def create
    comment = @post.comments.build comment_params
    comment.blog = @blog
    comment.user = current_user
    respond_to do |format| 
      if verify_recaptcha 
        if comment.save
         format.html { redirect_to blog_post_path(@blog, @post) }
        else
          format.html { redirect_to( blog_post_path(@blog, @post),
                      :flash => { :error => 'Invalid comment.' } ) }
        end
      else
          format.html { redirect_to( blog_post_path(@blog, @post),
              :flash => { :error => 'Are you bot?' } ) }
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
    render '/blogs/blog_not_found' unless @blog
  end
  def set_post
    @post = Post.find(params[:post_id])
  end
  def check_permission
    unless current_user && current_user.can_remove_comment?(@comment)
      head :unauthorized
    end
  end
end
