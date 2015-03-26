class UserNotifier < ApplicationMailer
  default :from => 'notifications@example.com'

  def new_post(post)
    @post = post
    @user = post.user
    @user.user_followers.each do |follower|
      mail(to: follower.email, subject: "New post - #{@user.username.capitalize}" )
    end
  end
end
