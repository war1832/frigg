require 'rails_helper'
RSpec.describe Post, type: :model do
  before(:each) do
    @user_1 = create(:user)
    @user_2 = create(:user, :user_2)
    @blog = @user_2.blogs.create(title: "Test", name: "Test")
  end

  it "sends mails to followers after creation" do
    @user_1.follow(@user_2)
    @post = @blog.posts.create(title: "New Post", body: "Body", user: @user_2)
    mail = ActionMailer::Base.deliveries.last
    expect(mail.to).to eq ["user_1@frigg.com"]
  end

  it "value of default rating" do
    post = @blog.posts.create(title: "New Post", body: "Body", user: @user_2)
    expect(post.average_rating).to eq 0
  end

  it "rating score" do
    post = @blog.posts.create(title: "New Post", body: "Body", user: @user_2)
    rating_user = post.ratings.create(user: @user_1, score: 4)
    rating_user_2 = post.ratings.create(user: @user_2, score: 5)
    expect(post.average_rating).to eq 4
  end
end
