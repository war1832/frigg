class FollowsController < ApplicationController
  def create
    @user = User.find(params[:user_id])
    current_user.follow(@user)
    render "follow_button"
  end

  def destroy
    @user = User.find(params[:user_id])
    current_user.stop_following(@user)
    render "follow_button"
  end
end
