require 'spec_helper'
feature 'Sign in' do
  scenario 'User Sign in' do
   user = create(:user)
   visit root_path
   fill_in 'user_login', :with => 'User1'
   fill_in 'user_password', :with => 'qwerty123'
   click_button 'Sign in'
   expect(page).to have_content('Listing Blogs')
  end
end
