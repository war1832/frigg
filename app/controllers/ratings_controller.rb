class RatingsController < ApplicationController
  before_action :authenticate_user!
  respond_to :js

  def update
    @rating = Rating.find(params[:id])
    @post = @rating.post
    @rating.update_attributes(score: params[:score])
  end
end
