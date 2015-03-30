class CommentsController < ApplicationController
  before_action :set_blog, only: [:create]
  before_action :set_post, only: [:create]
  
  def create
    comment = @post.comments.build comment_params
    comment.user = current_user
    respond_to do |format| 
      if verify_recaptcha 
        if comment.save
         format.html { redirect_to blog_post_path(@blog, @post) }
         format.json { render :show, status: :created, location: @post }
        else
          format.json { render json: @post.errors, status: :unprocessable_entity }
          format.html { redirect_to( blog_post_path(@blog, @post),
                      :flash => { :error => 'Invalid comment.' } ) }
        end
      else
          format.html { redirect_to( blog_post_path(@blog, @post),
              :flash => { :error => 'Are you bot?' } ) }
      end
    end
  end

  private
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
end
