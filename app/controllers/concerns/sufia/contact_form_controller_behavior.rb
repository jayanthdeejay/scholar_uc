module Sufia
  module ContactFormControllerBehavior
    extend ActiveSupport::Concern
    FAIL_NOTICE = "You must complete the Captcha to confirm the form.".freeze

    included do
      before_action :build_contact_form
    end

    def new
    end

    def create
      # not spam and a valid form
      if @contact_form.valid?
        ContactMailer.contact(@contact_form).deliver_now
        flash.now[:notice] = 'Thank you for your message!'
        @contact_form = ContactForm.new
      else
        flash.now[:error] = 'Sorry, this message was not sent successfully. '
        flash.now[:error] << @contact_form.errors.full_messages.map(&:to_s).join(", ")
      end
      render :new
    rescue RuntimeError => e
      logger.error("Contact form failed to send: #{e.inspect}")
      flash.now[:error] = 'Sorry, this message was not delivered.'
      render :new
    end

    protected

      def build_contact_form
        @contact_form = Sufia::ContactForm.new(contact_form_params)
      end

      def contact_form_params
        return {} unless params.key?(:sufia_contact_form)
        params.require(:sufia_contact_form).permit(:contact_method, :category, :name, :email, :subject, :message)
      end

  end
end
