module PostsHelper
  def show_link post
    content_tag :div do
        concat link_to 'Read More', post, :class =>'btn-xs btn-primary link-post'
      if current_user == post.user || current_user.try(:admin?)
        concat link_to 'Edit', edit_blog_post_path(post.blog, post), :class =>'btn-xs btn-primary link-post'
        concat link_to 'Destroy', blog_post_path(post.blog, post), :class =>'btn-xs btn-primary link-post',
                           method: :delete, data: { confirm: 'Are you sure?' }
      end
    end
  end
  
  def post_path post
    url_for [post.blog, post]
  end
  
  def show_rating
   content_tag(:div,'' , :id => "star") if current_user
  end
  
  def show_user_rating
    if current_user
      content_tag :div do
        concat content_tag(:p, "Your rating")
        concat content_tag(:div,'' , :id => "user_star") 
      end
    end
  end
  
  def render_ratings_js
    if current_user
      content_tag :script do
        concat render template: 'ratings/update.js.erb'
      end
    end
  end
end
