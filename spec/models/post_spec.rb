require 'rails_helper'

RSpec.describe Post, type: :model do

  it "sends mails to followers after creation" do
    @user_1 = User.create(username: "user1", email: "user_1@123.com", password: "qwerty123" )
    @user_2 = User.create(username: "user2", email: "user_2@123.com", password: "qwerty123" )
    @user_1.follow(@user_2)
    blog = @user_2.blogs.create(title: "Test", name: "SendMail")
    @post = blog.posts.create(title: "New Post", body: "Body", user: @user_2)
    mail = ActionMailer::Base.deliveries.last
    expect(mail.to).to eq ["user_1@123.com"]
  end
  
  it "value of default rating" do
    @user = User.create(username: "user", email: "user@123.com", password: "qwerty123" )
    blog = @user.blogs.create(title: "Test", name: "Rating")
    @post = blog.posts.create(title: "New Post", body: "Body", user: @user)
    expect(@post.average_rating).to eq 0
  end
  
  it "rating score" do
    @user = User.create(username: "user", email: "user@123.com", password: "qwerty123" )
    @user_2 = User.create(username: "user2", email: "user_2@123.com", password: "qwerty123" )
    blog = @user.blogs.create(title: "Test", name: "Rating")
    @post = blog.posts.create(title: "New Post", body: "Body", user: @user)
    rating_user = @post.ratings.create(user: @user, score: 4)
    rating_user_2 = @post.ratings.create(user: @user_2, score: 5)
    expect(@post.average_rating).to eq 4
  end

end
