module BlogsHelper
  def add_post_link blog, posts
    content_tag :div do
      if blog.user == current_user && posts.empty?
        concat 'Click '
        concat link_to 'Here', new_blog_post_path(blog)
        concat ' for add New Post '
      end
    end
  end
end
