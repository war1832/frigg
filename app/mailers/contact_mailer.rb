class ContactMailer < ApplicationMailer
  default :from => 'notifications@example.com'
  
  def new_contact(contact)
    @contact = contact
    User.admins.each do |admin|
      mail(to: admin.email, subject: "Contact - #{@contact.name.capitalize}" )
    end
  end
end
