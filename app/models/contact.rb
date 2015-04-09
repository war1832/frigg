class Contact < ActiveRecord::Base
  validates :name, :presence => true
  validates :email, :presence => true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  validates :message, :presence => true

  after_create :send_mail

  def send_mail
    ContactMailer.new_contact(self).deliver_later
  end
end
