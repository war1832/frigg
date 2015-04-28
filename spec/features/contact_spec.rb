require 'spec_helper'

feature 'Contact form' do
  scenario 'Full completed contact form' do
   visit root_path
   click_on 'Contact'
   fill_in 'contact_name', :with => 'test'
   fill_in 'contact_email', :with => 'test@frigg.com'
   fill_in 'contact_message', :with => 'Test message'
   allow_any_instance_of(ContactController).to receive(:verify_captcha).and_return(true)
   click_button 'Submit'
   expect(page).to have_content 'Sent message.'
  end

  scenario 'No captcha confirmation' do
   visit contact_new_path
   click_button 'Submit'
   expect(page).to have_content 'Invalid message.'
  end
end
