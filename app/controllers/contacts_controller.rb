class ContactsController < ApplicationController
    def new
        @contact = Contact.new
    end
    
    def create
        @contact = Contact.new(contact_params)
        if @contact.save
            #set variables for mailer arguments
            name = params[:contact][:name]
            email = params[:contact][:email]
            body = params[:contact][:comments]
            #send email
            ContactMailer.contact_email(name, email, body)
            #set Flash message to success
            flash[:success] = 'Messsage Sent'
            #redirect to same page.
            redirect_to new_contact_path
        else
            #on error, set flash message to error and refresh page
            flash[:danger] = 'Error Occurred. Message not sent.'
            redirect_to new_contact_path
        end
    end

    private
    #Need to whitelist parameters from the contact form
        def contact_params
            params.require(:contact).permit(:name, :email, :comments)
        end
        


end