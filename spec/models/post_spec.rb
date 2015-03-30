require 'rails_helper'

RSpec.describe Post, type: :model do

  before do
    @user_1 = User.create(username:"user1", email:"user_1@123.com", password:"qwerty123" )
    @user_2 = User.create(username:"user2", email:"user_1@123.com", password:"qwerty123" )
    @user_2.blogs <<  Blog.create( title: "test", name: "SendMail", user_id: @user_2.id )
    @post = @user_2.blogs.first.posts.build( title: "New Post", body: "Body", user_id: @user_2.id )
  end
 
  it "send mail" do
    @user_1.follow(@user2)
    @user_2.send_user_notifier @post if @post.save
  end

end
