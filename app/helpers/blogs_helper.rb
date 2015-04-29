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
    if post
    url_encode = ERB::Util.url_encode(request.original_url)
      url = "https://www.facebook.com/dialog/feed?app_id=1434451423519888&display=popup&caption=#{post.title}&link=#{url_encode}&redirect_uri=#{url_encode}"
      link_to(raw('<i class="fa fa-facebook"></i>'), url, { target: '_blank',
                                                    class: 'btn btn-primary' } )
    end
  end
  def share_btn_twitter post
    if post
      url = "http://twitter.com/share?url=#{ERB::Util.url_encode(request.original_url)}&text=#{post.title}"
      link_to(raw('<i class="fa fa-twitter"></i>'), url, { target: '_blank',
                                                       class: 'btn btn-info' } )
    end
  end
end
