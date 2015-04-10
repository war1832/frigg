module Api
  class UsersController < ApplicationController
    respond_to :json
    def index
      respond_with User.all
    end
    
    def show
      user = User.find(params[:id])
      if user
        respond_with user
      else
        head 404
      end
    end
  end
end
