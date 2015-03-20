class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    comment = @post.comments.build comment_params
    comment.user = current_user
    respond_to do |format| 
      if comment.save
       format.html { redirect_to blog_post_path(blog_id: @post.blog.name,
                                                id: @post.id  ) }
       format.json { render :show, status: :created, location: @post }
      else
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  def comment_params
    params[:comment].permit(:body)
  end
end
