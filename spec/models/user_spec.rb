require 'rails_helper'

RSpec.describe User, type: :model do
  it 'has valid factory' do
    user = build(:user)
    expect(user).to be_valid
  end

  it '#full_name' do
    user = build(:user)
    expect(user.full_name).to eq('Juan Perez')
  end

  it "#admin?" do
    user = create(:admin)
    expect(user.admin?).to eq(true)
  end

  it '#facebook_user?' do
    user = build(:user)
    expect(user.facebook_user?).to eq(false)
  end

  it 'user admin can manage blog' do
    blog =  add_blog create(:user)
    admin = create(:admin)
    expect(admin.can_manager?(blog)).to eq(true)
  end

  it '#post_count' do
    user = create(:user)
    blog = add_blog user
    blog.posts.create(title: "New Post", body: "Body", user: user)
    expect(user.post_count).to eq(1)
  end

  it '#comment_count' do
    user = create(:user)
    blog = add_blog user
    post = add_post(blog, user)
    2.times { post.comments.create(body: 'Comment.', user: user) }
    expect(user.comment_count).to eq(2)
  end

  it 'user can remove comment' do
    user = create(:user)
    blog = add_blog user
    post = add_post(blog, user)
    comment = post.comments.create(body: 'Comment.', user: user)
    expect(user.can_remove_comment?(comment)).to eq(true)
  end

  it 'user add editor' do
    user = create(:user)
    editor = create(:user, :user_2)
    blog = add_blog user
    blog.editors.create(blog: blog, user: editor)
    expect(blog.editors.count).to eq(1)
  end

  it 'editor can manage blog' do
    user = create(:user)
    editor = create(:user, :user_2)
    blog = add_blog user
    blog.editors.create(blog: blog, user: editor)
    expect(editor.can_manager?(blog)).to eq(true)
  end

  it 'User can destroy your own comment' do
    user = create(:user)
    user_comment = create(:user, :user_2)
    blog = add_blog user
    post = add_post(blog, user)
    comment = post.comments.create(body: 'Comment.', user: user_comment)
    expect(user_comment.can_remove_comment?(comment)).to eq(true)
  end

  it 'user followers' do
    user_1 = create(:user)
    user_2 = create(:user, :user_2)
    user_2.follow(user_1)
    expect(user_1.followers.count).to eq(1)
  end
end

def add_blog user
  user.blogs.create(title: "Test", name: "Test")
end

def add_post blog, user
  blog.posts.create(title: "New Post", body: "Body", user: user)
end
