module ApplicationHelper
  def avatar_url(user, size)
    user.gravatar_url(size) if user
  end

  def resource_class
    devise_mapping.to
  end
end
