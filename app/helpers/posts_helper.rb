module PostsHelper
  def show_link post
    content_tag :div do
        concat link_to 'Read More', blog_post_path(:id =>post,
                                          :blog_id => post.blog.name),
                                          :class =>'btn-xs btn-primary link-post'
      if current_user == post.user
        concat link_to 'Edit', edit_blog_post_path(:id => post.id,
                                            :blog_id => post.blog.name),
                        :class =>'btn-xs btn-primary link-post'
        concat link_to 'Destroy', blog_post_path(:id => post.id,
                                          :blog_id => post.blog.name),
                           :class =>'btn-xs btn-primary link-post',
                           method: :delete, data: { confirm: 'Are you sure?' }
      end
    end
  end
end
