module PostsHelper
  def show_link post
    content_tag :div do
        concat link_to 'Read More', post, :class =>'btn-xs btn-primary link-post'
      if current_user == post.user
        concat link_to 'Edit', post, :class =>'btn-xs btn-primary link-post'
        concat link_to 'Destroy', post, :class =>'btn-xs btn-primary link-post',
                           method: :delete, data: { confirm: 'Are you sure?' }
      end
    end
  end
  
  def post_path post
    url_for [post.blog, post]
  end
end
