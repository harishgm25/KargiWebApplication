class Users::SessionsController < Devise::SessionsController
 respond_to :html,:json 

 before_filter :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
   def create

      if(request.format == "text/html")
        super
        return
      else
        resource = warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#failure")
        sign_in_and_redirect(resource_name, resource)
      end
    end
    def sign_in_and_redirect(resource_or_scope, resource=nil)
        scope = Devise::Mapping.find_scope!(resource_or_scope)
        resource ||= resource_or_scope
        sign_in(scope, resource) unless warden.user(scope) == resource

        return render :json => {:token => current_user.authentication_token,:userid => "" +current_user._id,:success => true, :email => current_user.email,:roll => current_user.roll}
      end


    def failure
        return render :json => {:success => false, :errors => ["Login failed."]}
      end

      protected

      def json_request?
        request.format.json?
      end
         
   

  


  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_in_params
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:email,:mobile,:password,:password_confirmation,:remember_me) }
  end
end
