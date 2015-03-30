require 'rails_helper'

RSpec.describe Post, type: :model do

  it "sends mails to followers after creation" do
    @user_1 = User.create(username:"user1", email:"user_1@123.com", password:"qwerty123" )
    @user_2 = User.create(username:"user2", email:"user_2@123.com", password:"qwerty123" )
    @user_1.follow(@user_2)
    blog = @user_2.blogs.create(title: "test", name: "SendMail")
    @post = blog.posts.create(title: "New Post", body: "Body", user: @user_2)
    mail = ActionMailer::Base.deliveries.last
    expect(mail.to).to eq ["user_1@123.com"]
  end

end
