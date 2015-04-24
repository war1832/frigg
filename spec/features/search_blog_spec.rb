require 'spec_helper'
feature 'Search the Blog' do
  scenario 'Reading the blog index' do
   visit root_path
   fill_in 'search', :with => 'test'
   click_button 'search_button'
   expect(page).to have_text('Search Results')
  end
end
