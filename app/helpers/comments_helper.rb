module CommentsHelper
  def comment_avatar_url(user)
    user ? user.gravatar_url(80) : "anonymous.jpeg"
  end

  private
  def username user
    user ? link_to(user.username.capitalize, user_path(user)) : "Anonymous"
  end
end
