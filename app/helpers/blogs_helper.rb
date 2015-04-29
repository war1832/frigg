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

  def share_btn_facebook post
    url = "https://www.facebook.com/dialog/feed?app_id=1434451423519888&display=popup&caption=#{post.title}&link=#{current_url_encode}"
    build_btn url, post, 'facebook'
  end
  def share_btn_twitter post
    url = "http://twitter.com/share?url=#{current_url_encode}&text=#{post.title}"
    build_btn url, post, 'twitter'
  end

  private
  def build_btn url, post, social
    if post
      body = "<i class='fa fa-#{social}'></i>"
       link_to(raw(body), url, { target: '_blank', class: 'btn btn-info' } )
    end
  end

  def current_url_encode
    url_encode = ERB::Util.url_encode(request.original_url)
  end
end
