require 'rails_helper'

describe BlogsController do
  let(:blog) { blog = build(:blog) }

  before :each do
    @user = create(:user)
    @user.confirm!
    sign_in @user
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates the blog' do
        blog.user = @user
        post :create, blog: blog.attributes
        expect(Blog.count).to eq(1)
      end
    end
  end
end
