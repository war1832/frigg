class ContactController < ApplicationController
  before_action :verify_captcha, only: [:create]

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    respond_to do |format|
      if @contact.valid?
        if @contact.save
          format.html { redirect_to contact_new_path, :notice => 'Sent message.' }
        else
          format.html { redirect_to contact_new_path,
            :flash => { :error => 'Error to send message. Please try again.' } }
        end
      else:D
        format.html { redirect_to( contact_new_path, :flash => { :error => 'Invalid message.' } ) }
      end
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :message)
  end

  def verify_captcha
    unless verify_recaptcha
      respond_to do |format|
        format.html { redirect_to( contact_new_path, :flash => { :error => 'Are you bot?.' } ) }
      end
    end
  end
end
