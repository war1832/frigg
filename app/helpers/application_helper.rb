module ApplicationHelper
  def avatar_url(user, size)
    get_gravatar(user, size) if user
  end
  
  def resource_class
    devise_mapping.to
  end

  private
  def get_gravatar(user, size)
    user.gravatar_url(:rating => 'R', :secure => true,
                      :size => size, :default => "mm" )
  end
end
