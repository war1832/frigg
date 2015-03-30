class FollowsController < ApplicationController
  before_action :authenticate_user!
  def create
    @user = User.find(params[:user_id])
    current_user.follow(@user)
    render_view
  end

  def destroy
    @user = User.find(params[:user_id])
    current_user.stop_following(@user)
    render_view
  end

  private
  def render_view
    render "follow_button"
  end
end
